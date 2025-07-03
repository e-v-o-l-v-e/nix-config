{ config, ... }:
# this is where the per host configuration happens
# all options and their default values are set in ./options.nix

# the username is set globally as the username option's default
# you can override it per host or change it in ./options.nix to use the same on every machine, current is "evolve"
{
  config = {
    
    #=== HOME ===#
    programs.nvf.enable = true;
    programs.zen.enable = false;

    home.keyboard = {
      layout = "gb";
      variant = "extd";
    };

    # home-manager version at the time of first install, do not change
    home.stateVersion = "25.05";

    #=== SYSTEM ===#

    # nixos version at the time of first install, do not change
    system.stateVersion = "25.05";

    # Apps #
    login-manager = null;
    services.kanata.enable = false;

    # Network #
    services.tailscale.enable = true;
    server.airvpn.enable = true;
    interfaces.eth0.wakeOnLan.enable = true;


    #=== SERVER ===#
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
    };
  };
}
