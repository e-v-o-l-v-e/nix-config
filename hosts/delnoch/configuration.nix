{
  lib,
  HM,
  pkgs,
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

      boot.loader.systemd-boot.enable = true;
      
      # nixos version at the time of first install, do not change
      system.stateVersion = "25.05";

      boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_6_6;

      # Desktop #
      login-manager = null;

      # Network #
      services.tailscale.enable = true;
      networking.interfaces.enp2s0.wakeOnLan.enable = true; 
      
      networking.defaultGateway = { address = "192.168.0.254"; interface = "enp2s0"; };
      networking.interfaces.enp2s0 = {
        useDHCP = false;
        ipv4.addresses = [{ 
          address = "192.168.0.216"; 
          prefixLength = 24;
        }];
      };


      #=#=#=# SERVER SPECIFIC #=#=#=#

      server = {
        enable = true;

        dataPath = "/data";
        configPath = "/services-config";

        domain = "imp-network.com";
        domainSecondary = "jeudefou.com";

        vpn.enable = true;
        vpn.forwardedPort = 18086;      

        allowedSubnets = [ "192.168.0.0/24" ];
      };

      security.sudo.wheelNeedsPassword = false;

      # ZFS
      boot.zfs.extraPools = [ "tank" ];
      boot.supportedFilesystems.zfs = true;
      networking.hostId = "ea274802";
      environment.systemPackages = [ pkgs.zfs ];


      # # Services #
      services = {
        # reverse proxy
        caddy.enable = true;

        # remote access
        cloudflared.enable = true;

        # notes
        silverbullet.enable = false; # pkgs kinda broken rn

        # utilities
        local-content-share.enable = true;
        pingvin-share.enable = true;

        # cloud
        opencloud.enable = true;

        # media viewing/request
        jellyfin.enable = true;
        jellyseerr.enable = true;
        kavita.enable = true;

        # *arr / torrents
        qbittorrent.enable = true;

        prowlarr.enable = true;
        radarr.enable = true;
        sonarr.enable = true;
        lidarr.enable = true;

        slskd.enable = true;

        immich.enable = true;
      };

      server.docker.silverbullet.enable = true;

      server.hugo.enable = true;
      server.hugo.tuto-tailscale.enable = true;

      virtualisation.docker.enable = true;
    })
  ];
}
