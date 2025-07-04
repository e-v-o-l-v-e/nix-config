{ config, ... }:
let
  cfg = config.server;
in
{
  services.radarr = {
    group = cfg.mediaGroupName;
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
