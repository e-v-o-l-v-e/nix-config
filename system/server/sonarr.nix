{ config, ... }:
let
  cfg = config.server;
in
{
  services.sonarr = {
    inherit (cfg.services.sonarr) enable;
    group = cfg.mediaGroupName;
    dataDir = "${cfg.configPath}/sonarr";
    settings = {
      update.mechanism = "external";
      server = {
        urlbase = "localhost";
        port = 8989;
        bindaddress = "*";
      };
    };
  };
}
