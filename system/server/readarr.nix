{ config, ... }:
let
  cfg = config.server;
in
{
  services.readarr = {
    inherit (cfg.services.readarr) enable;
    group = cfg.mediaGroupName;
    dataDir = "${cfg.configPath}/readarr";
    settings = {
      update.mechanism = "external";
      server = {
        urlbase = "localhost";
        port = 8787;
        bindaddress = "*";
      };
    };
  };
}
