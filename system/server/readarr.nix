{ config, ... }:
let
  cfg = config.server;
in
{
  services.readarr = {
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
