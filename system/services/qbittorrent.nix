{ lib, config, username, ... }: let
  cfg = config.server;
  fqdn = cfg.domain;

  webuiPort = 8088;
  torrentingPort = 18086;

  namespaceAddress = "192.168.15.1";
in {
  services.qbittorrent = {
    inherit webuiPort torrentingPort;
    profileDir = "${config.server.configPath}/qbittorrent";

    serverConfig = {
      LegalNotice.Accepted = true;

      Preferences = {
        General.Locale = "en";

        WebUI = {
          Username = username;
          Password_PBKDF2 = "@ByteArray(hKJrE1tjS7lk4k99xpL2tw==:Zstd8JKmqVEudK3rJ8yOITJX036grnuyODBg+a86bY7CRBbFL1cpE9iIYxqr3kp5mcBEFROY/3K6Wiq8f0STtQ==)";
          AuthSubnetWhitelistEnabled = false;
        };

        Session = {
          DefaultSavePath = "${cfg.dataPath}/torrents";
        };
      };
    };

    user = "qbittorrent";
    group = cfg.mediaGroupName;
  };

  services.caddy.virtualHosts = lib.mkIf config.services.qbittorrent.enable {
    "qbittorrent.${fqdn}" = {
      extraConfig = ''
        reverse_proxy http://${namespaceAddress}:${toString webuiPort}
      '';
    };
  };

  vpnNamespaces.qbitvpn = {
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

    openVPNPorts = [{
      port = torrentingPort;
      protocol = "both";
    }];
  };

  systemd.services = lib.mkIf config.services.qbittorrent.enable {
    qbittorrent.vpnConfinement = {
      enable = true;
      vpnNamespace = "qbitvpn";
    };
  };
}
