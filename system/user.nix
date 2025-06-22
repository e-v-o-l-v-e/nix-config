{
  pkgs,
  lib,
  username,
  hostname,
  config,
  ...
}:
let
  extraGroups = [ "audio" "docker" "input" "inputs" "kvm" "libvirtd" "lp" "networkmanager" "scanner" "uinputs" "users" "video" "wheel" ];
  cfg = config.soft.sops-nix;
in
{
  users = {
    users.${username} = {
      isNormalUser = true;
      homeMode = "755";
      inherit extraGroups;
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
  users.mutableUsers = lib.mkIf cfg.enable (lib.mkForce false);
}
