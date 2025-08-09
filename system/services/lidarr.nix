{ config, ... }:
let
  cfg = config.server;
  port = 8686;
  fqdn = config.server.domain;
in
{
  services.lidarr = {
    group = cfg.mediaGroupName;
    dataDir = "${cfg.configPath}/lidarr";
    settings = {
      update.mechanism = "external";
      server = {
        inherit port;
        urlbase = "localhost";
        bindaddress = "*";
      };
    };
  };

  services.caddy.virtualHosts."lidarr.${fqdn}" = {
    extraConfig = ''
      reverse_proxy http://localhost:${toString port}
    '';
  };
}
