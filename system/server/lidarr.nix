{ config, ... }:
let
  cfg = config.server;
in
{
  services.lidarr = {
    group = cfg.mediaGroupName;
    dataDir = "${cfg.configPath}/lidarr";
    settings = {
      update.mechanism = "external";
      server = {
        urlbase = "localhost";
        port = 8686;
        bindaddress = "*";
      };
    };
  };
}
