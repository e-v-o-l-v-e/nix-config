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
      personal.enable = false;

      sops-nix.enable = true;

      keyboard = {
        layout = "gb";
        variant = "extd";
      };
    }
    ( if HM then {
      #=#=#=# HOME #=#=#=#
      # Apps #
      programs.nvf.enable = true;
      programs.nvf.maxConfig = true;

      programs.zellij.enable = false;
      programs.tmux.enable = true;

      # home-manager version at the time of first install, do not change
      home.stateVersion = "25.05";
    }
    else
    {
      #=#=#=# SYSTEM #=#=#=#
      # nixos version at the time of first install, do not change
      system.stateVersion = "25.05";

      # Desktop #
      login-manager = null;

      # Network #
      services.tailscale.enable = true;
      interfaces.eth0.wakeOnLan.enable = true;


      #=#=#=# SERVER SPECIFIC #=#=#=#

      server = {
        enable = true;
        dataPath = "/data";
        configPath = "/services-config";
      };

      server.vpn.enable = true;

      # Services #
      services = {
        # reverse proxy
        caddy.enable = true;

        # notes
        services.silverbullet.enable = true;

        # media viewing/request
        jellyfin.enable = true;
        jellyseerr.enable = true;

        # *arr / torrents
        prowlarr.enable = true;
        radarr.enable = true;
        sonarr.enable = true;
        lidarr.enable = true;
        readarr.enable = true;
        opencloud.enable = false;
      };
    })
  ];
}
