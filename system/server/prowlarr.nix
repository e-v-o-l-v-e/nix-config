{ config, ...}: let
  cfg = config.server.services.prowlarr;
in {
  services.prowlarr = {
    inherit (cfg) enable;
    dataDir = "${config.server.configPath}/prowlarr";
    settings = {
      update.mechanism = "external";
      server = {
        urlbase = "localhost";
        port = 9696;
        bindaddress = "*";
      };
    }
    ;
  };
}
