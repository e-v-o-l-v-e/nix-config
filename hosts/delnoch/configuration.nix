{ config, ... }:
# this is where the per host configuration happens
# all options and their default values are set in ./options.nix

# the username is set globally as the username option's default
# you can override it per host or change it in ./options.nix to use the same on every machine, current is "evolve"
{
  config = {
    
    #=#=#=# HOME #=#=#=#

    personal.enable = false;

    home.keyboard = {
      layout = "gb";
      variant = "extd";
    };

    # Apps #
    programs.nvf.enable = true;
    programs.nvf.maxConfig = true;

    programs.zen.enable = false;

    gui.packages.enable = false;

    # Theming #
    gui.theme = "light";

    gui.quickshell.enable = false;
    gui.quickshell.caelestia = false;

    programs.stylix.enable = false;
    programs.stylix.colorScheme = "one-light";

    # home-manager version at the time of first install, do not change
    home.stateVersion = "25.05";


    #=#=#=# SYSTEM #=#=#=#

    laptop.enable = false;
    
    # nixos version at the time of first install, do not change
    system.stateVersion = "25.05";

    # Apps #
    login-manager = null;
    programs.hyprland.enable = false;
    services.dispayManager.plasma6.enable = false;

    services.kanata.enable = false; # remapping tool, this enable my personal config following a home-row scheme

    # Network #
    services.tailscale.enable = true;
    server.airvpn.enable = true;
    interfaces.eth0.wakeOnLan.enable = true;



    #=#=#=# SERVER SPECIFIC #=#=#=#

    server = {
      enable = true;
      dataPath = "/data";
      configPath = "/services-config";
    };

    # Services #
    services = {
      # reverse proxy
      caddy.enable = true;

      # media viewing/request
      jellyfin.enable = true;
      jellyseerr.enable = true;

      # *arr / torrents
      prowlarr.enable = true;
      radarr.enable = true;
      sonarr.enable = true;
      lidarr.enable = true;
      readarr.enable = true;
      opencloud.enable = true;
    };
  };
}
