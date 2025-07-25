{config, ...}: let
  cfg = config.server;
  fqdn = config.server.domain;

  port = 8989;
in {
  services.sonarr = {
    group = cfg.mediaGroupName;
    dataDir = "${cfg.configPath}/sonarr";
    settings = {
      update.mechanism = "external";
      server = {
        inherit port;
        urlbase = "localhost";
        bindaddress = "*";
      };
    };
  };

  services.caddy.virtualHosts."sonarr.${fqdn}" = {
    extraConfig = ''
      reverse_proxy http://localhost:${toString port}
    '';
  };
}
