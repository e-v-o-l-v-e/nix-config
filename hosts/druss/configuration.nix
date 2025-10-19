{
  lib,
  HM,
  config,
  ...
}:
# this is where the per host configuration happens
# all options and their default values are set in ./options.nix
# the username is set globally as the username option's default
# you can override it per host or change it in ./options.nix to use the same on every machine, current is "evolve"
{
  config = lib.mkMerge [
    {
      #=#=#=# HOME #=#=#=#
      personal.enable = true;

      sops-nix.enable = true;

      keyboard = {
        layout = "gb";
        variant = "extd";
      };

      # Theming #
      gui.enable = true;

      programs.waybar.enable = false;

      gaming.enable = true;
      gaming.full = true;
    }
    (
      if HM
      then {
        #=#=#=# HOME #=#=#=#
        # Apps #
        programs.nvf.enable = true;
        programs.nvf.maxConfig = true;

        programs.zellij.enable = false;

        programs.kitty.enable = false;
        programs.kitty.nixConfig.enable = false;

        programs.zen-browser.enable = true;

        wayland.windowManager.hyprland.enable = false; # manage hyprland settings with home-manager

        # home-manager version at the time of first install, do not change
        home.stateVersion = "25.05";
      }
      else {
        #=#=#=# SYSTEM #=#=#=#
        laptop.enable = false;


        boot.loader.systemd-boot.enable = true;

        gpu = "amd";

        # nixos version at the time of first install, do not change
        system.stateVersion = "25.05";

        # Desktop #
        login-manager = "sddm";

        programs.hyprland.enable = false;

        services.desktopManager.plasma6.enable = true;

        # Apps #
        services.kanata.enable = false; # remapping tool, this enable my personal config following a home-row scheme

        # Network #
        services.tailscale.enable = true;
        networking.interfaces.enp6s0.wakeOnLan.enable = true;
        hardware.bluetooth.enable = true;

        # services testing #
        server.enable = true;
        #
        server.domain = "imp-network.com";
        #
        services.caddy.enable = false;
        services.silverbullet.enable = false;
        # services.radarr.enable = true;
        # services.sonarr.enable = true;
        services.opencloud.enable = true;
      }
    )
  ];
}
