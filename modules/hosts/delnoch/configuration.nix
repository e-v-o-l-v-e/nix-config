{ self, ... }:
let
  hostname = "delnoch";
  system = "x86_64-linux";
  mainUser = "evolve";
  users = [ mainUser ];
in
{
  flake.nixosConfigurations.${hostname} = self.lib.mkNixos {
    inherit hostname system;
    stateVersion = "25.05";
  };

  flake.modules.nixos.delnoch =
    { pkgs, lib, ... }:
    {
      imports =
        with self.modules.nixos;
        [
          # system
          systemd-boot
          delnoch-sops

          # server base
          server
          docker

          # reverse proxy
          caddy
          cloudflared

          # media
          seerr
          jellyfin
          navidrome
          kavita

          # cloud
          immich
          opencloud

          # download
          arr
          qbittorrent
          slskd

          # docker services
          silverbullet

          # utilities
          bentopdf
          local-content-share
          matrix
          olivetin
          pingvin-share
          sites
          spliit

          # network
          tailscale
        ]
        ++ map (user: self.modules.nixos.${user}) users;

      # Intel i3-7100T - linux 6.12
      boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_6_12;

      # ZFS
      boot.zfs.extraPools = [ "tank" ];
      boot.supportedFilesystems.zfs = true;
      networking.hostId = "ea274802";
      environment.systemPackages = [ pkgs.zfs ];

      # Network
      networking.defaultGateway = {
        address = "192.168.0.254";
        interface = "enp2s0";
      };
      networking.interfaces.enp2s0 = {
        ipv4.addresses = [
          {
            address = "192.168.0.216";
            prefixLength = 24;
          }
        ];
        wakeOnLan.enable = true;
      };

      # Server config
      server = {
        enable = true;

        dataPath = "/data";
        configPath = "/services-config";

        domain = "imp-network.com";
        domainSecondary = "jeudefou.com";

        vpn.enable = true;
        vpn.forwardedPort = 52106;

        allowedSubnets = [ "192.168.0.0/24" ];
        openPorts = [
          80
          443
          2283
        ];
      };

      # Services
      services = {
        caddy.enable = true;
        cloudflared.enable = true;
        local-content-share.enable = true;
        olivetin.enable = true;
        opencloud.enable = true;
        immich.enable = true;
        matrix-conduit.enable = true;
        jellyfin.enable = true;
        kavita.enable = true;
        qbittorrent.enable = true;
        prowlarr.enable = true;
        radarr.enable = true;
        sonarr.enable = true;
        navidrome.enable = true;
        slskd.enable = true;
      };

      virtualisation.docker.enable = true;

      server.docker = {
        silverbullet.enable = true;
        silverbullet-public.enable = true;
        seerr.enable = true;
        pingvin-share-x.enable = true;
        bentopdf.enable = true;
        spliit.enable = true;
      };

      server.hugo.enable = true;

      security.sudo.wheelNeedsPassword = false;

      systemd.settings.Manager = {
        DefaultTimeoutStartSec = "30s";
        DefaultTimeoutStopSec = "30s";
      };
    };
}
