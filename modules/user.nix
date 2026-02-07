{ config, pkgs, ... }:
let
  inherit (config.meta) username;
in
{
  flake.modules.nixos.user =
    let
      extraGroups = [
        "audio" "docker" "input" "inputs" "key"
        "kvm" "libvirtd" "lp" "networkmanager"
        "scanner" "uinputs" "users" "video" "wheel"
      ];
    in
    {
      users = {
        mutableUsers = true;
        users.${username} = {
          isNormalUser = true;
          homeMode = "700";
          inherit extraGroups;
          home = "/home/${username}";
          linger = true;
        };
        defaultUserShell = pkgs.fish;
      };

      environment.shells = with pkgs; [
        fish
        bash
      ];

      programs.fish.enable = true;

      # sops.secrets = lib.mkIf cfg.enable {
      #   "password-${hostname}".neededForUsers = true;
      # };
    };

  flake.modules.homeManager.user = {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    inherit (config) keyboard;
  };
  };
}
