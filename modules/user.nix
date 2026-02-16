{
  inputs,
  pkgs,
  ...
}:
{
  flake.modules.nixos.user = { config, ... }:
    let
      extraGroups = [
        "audio" "docker" "input" "inputs" "key" "kvm"
        "libvirtd" "lp" "networkmanager" "scanner"
        "uinputs" "users" "video" "wheel" 
        ];
    in
    {
      users =
        {
          mutableUsers = true;
          users.${config.preferences.username} = {
            isNormalUser = true;
            homeMode = "700";
            inherit extraGroups;
            home = "/home/${config.preferences.username}";
            linger = true;
          };
          defaultUserShell = pkgs.fish;
        };

      # sops.secrets = lib.mkIf cfg.enable {
      #   "password-${hostname}".neededForUsers = true;
      # };
    };

  flake.modules.homeManager.user = { config, ... }: {
    home = {
        homeDirectory = "/home/${config.preferences.username}";
      };
    programs.home-manager.enable = true;
  };
}
