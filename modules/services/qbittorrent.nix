{ inputs, ... }:
{
  flake.modules.nixos.qbittorrent =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.server;
      fqdn = cfg.domain;

      webuiPort = 8088;
      torrentingPort = cfg.vpn.forwardedPort;

      namespaceAddress = "192.168.15.1";
    in
    {
      imports = [ inputs.vpn-confinement.nixosModules.default ];

      services.qbittorrent = {
        inherit webuiPort torrentingPort;
        profileDir = "${cfg.configPath}/qbittorrent";
        user = cfg.serverUserName;
        group = cfg.serverGroupName;
        extraArgs = [ "--confirm-legal-notice" ];
      };

      services.caddy.virtualHosts = lib.mkIf config.services.qbittorrent.enable {
        "qbittorrent.${fqdn}".extraConfig = ''
          import cfdns
          reverse_proxy http://${namespaceAddress}:${toString webuiPort}
        '';
      };

      environment.systemPackages = [
        pkgs.qbittorrent-cli
      ]
      ++ lib.optional cfg.vpn.enable pkgs.wireguard-tools;

      vpnNamespaces.qbitvpn = lib.mkIf cfg.vpn.enable {
        inherit (cfg.vpn) enable;
        wireguardConfigFile = config.sops.secrets."wg-airvpn.conf".path;
        inherit namespaceAddress;
        accessibleFrom = [
          "127.0.0.1"
          "100.104.213.127"
          "100.91.197.78"
          "100.73.148.62"
          "192.168.0.0/24"
        ];
        portMappings = [
          {
            from = webuiPort;
            to = webuiPort;
          }
        ];
        openVPNPorts = lib.optionals (!isNull torrentingPort) [
          {
            port = torrentingPort;
            protocol = "both";
          }
        ];
      };

      systemd.services = lib.mkIf config.services.qbittorrent.enable {
        qbittorrent = {
          vpnConfinement = {
            enable = true;
            vpnNamespace = "qbitvpn";
          };

          # Bind the daemon lifecycle to the qbitvpn namespace setup
          after = [
            "qbitvpn.service"
            "network-online.target"
          ];
          requires = [ "qbitvpn.service" ];

          serviceConfig = {
            UMask = "0002";
            Restart = "no";
            RestartSec = "10s";
            # delete the lockfile before starting
            ExecStartPre = "${pkgs.coreutils}/bin/rm -f ${cfg.configPath}/qbittorrent/qBittorrent/config/lockfile";
          };
        };
      };
    };
}
