{
  pkgs,
  lib,
  username,
  hostname,
  config,
  ...
}:
let
  extraGroups = [ "audio" "docker" "input" "inputs" "kvm" "libvirtd" "lp" "networkmanager" "scanner" "server" "uinputs" "users" "video" "wheel" ];
  cfg = config.soft.sops-nix;
in
{
  users = {
    mutableUsers = false;
    users.${username} = {
      isNormalUser = true;
      homeMode = "700";
      inherit extraGroups;
      home = "/home/${username}";
      hashedPasswordFile = lib.mkIf cfg.enable (
        builtins.getAttr "password-${hostname}" config.sops.secrets config.sops.secrets.defaultPassword
      );
    };
    defaultUserShell = pkgs.fish;
  };
  environment.shells = with pkgs; [
    fish
    bash
  ];

  programs.fish.enable = true;

  sops.secrets."password-${hostname}".neededForUsers = true;
  # users must not be mutable if you want to configure your password with sops
  # users.mutableUsers = lib.mkIf cfg.enable (lib.mkForce false);
}
