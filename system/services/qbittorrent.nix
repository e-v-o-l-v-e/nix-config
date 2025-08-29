{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.server;
  fqdn = cfg.domain;

  webuiPort = 8088;
  torrentingPort = cfg.vpn.forwardedPort;

  namespaceAddress = "192.168.15.1";
in {
  services.qbittorrent = {
    inherit webuiPort torrentingPort;
    profileDir = "${config.server.configPath}/qbittorrent";

    user = cfg.serverUserName;
    group = cfg.serverGroupName;
  };

  services.caddy.virtualHosts = lib.mkIf config.services.qbittorrent.enable {
    "qbittorrent.${fqdn}" = {
      extraConfig = ''
        import cfdns
        reverse_proxy http://${namespaceAddress}:${toString webuiPort}
      '';
    };
  };

  environment.systemPackages = lib.mkIf cfg.vpn.enable (with pkgs; [
    wireguard-tools
  ]);

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

    portMappings = [{
      from = webuiPort;
      to = webuiPort;
      }];

    openVPNPorts = lib.optionals (!isNull torrentingPort) [{
      port = torrentingPort;
      protocol = "both";
    }];
  };

  systemd.services = lib.mkIf config.services.qbittorrent.enable {
    qbittorrent = {
      vpnConfinement = {
        enable = true;
        vpnNamespace = "qbitvpn";
      };

      serviceConfig = {
        ExecStop = "${pkgs.coreutils}/bin/kill -s SIGTERM $MAINPID";
        UMask = "0002";
      };
    };
  };
}
