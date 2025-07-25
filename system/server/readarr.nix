{ config, ... }:
let
  cfg = config.server;

  port = 8787;
  fqdn = config.server.domain;
in
{
  services.readarr = {
    group = cfg.mediaGroupName;
    dataDir = "${cfg.configPath}/readarr";
    settings = {
      update.mechanism = "external";
      server = {
        inherit port;
        urlbase = "localhost";
        bindaddress = "*";
      };
    };
  };

  services.caddy.virtualHosts."readarr.${fqdn}" = {
    extraConfig = ''
      reverse_proxy http://localhost:${toString port}
    '';
  };
}
