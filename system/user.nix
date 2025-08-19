{
  pkgs,
  username,
  hostname,
  config,
  lib,
  ...
}:
let
  cfg = config.sops-nix;

  extraGroups = [ 
    "audio" "docker" "input" "inputs" "key"
    "kvm" "libvirtd" "lp" "networkmanager"
    "scanner" "uinputs" "users" "video" "wheel"
    config.server.serverGroupName
  ];
in
{
  users = {
    mutableUsers = false;
    users.${username} = {
      isNormalUser = true;
      homeMode = "700";
      inherit extraGroups;
      home = "/home/${username}";
      hashedPasswordFile = lib.mkIf cfg.enable config.sops.secrets."password-${hostname}".path;
    };
    defaultUserShell = pkgs.fish;
  };

  environment.shells = with pkgs; [
    fish
    bash
  ];

  programs.fish.enable = true;

  # documentation.man.generateCaches = config.users.defaultUserShell != pkgs.fish;

  sops.secrets = lib.mkIf cfg.enable { 
    "password-${hostname}".neededForUsers = true; 
  };
  # users must not be mutable if you want to configure your password with sops
  # users.mutableUsers = lib.mkIf cfg.enable (lib.mkForce false);
}
