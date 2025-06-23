{ config, ... }:
let
  cfg = config.server;
in
{
  services.radarr = {
    inherit (cfg.services.radarr) enable;
    group = cfg.groupName;
    dataDir = "${cfg.configPath}/radarr";
    settings = {
      update.mechanism = "external";
      server = {
        urlbase = "localhost";
        port = 7878;
        bindaddress = "*";
      };
    };
  };
}
