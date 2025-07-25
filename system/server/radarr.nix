{ config, ... }:
let
  cfg = config.server;

  port = 7878;
  fqdn = config.server.domain;
in
{
  services.radarr = {
    group = cfg.mediaGroupName;
    dataDir = "${cfg.configPath}/radarr";
    settings = {
      update.mechanism = "external";
      server = {
        inherit port;
        urlbase = "localhost";
        bindaddress = "*";
      };
    };
  };

  services.caddy.virtualHosts."radarr.${fqdn}" = {
    extraConfig = ''
      reverse_proxy http://localhost:${toString port}
    '';
  };
}
