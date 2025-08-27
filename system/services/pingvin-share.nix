{ config, lib, ... }: let
  cfg = config.server;
  fqdn = cfg.domain;
  frontend.port = 4000;
  backend.port = 4001;
  hostname = "share.${fqdn}";
in {
  services.pingvin-share = {
    inherit frontend backend;

    dataDir = cfg.dataPath + "/pingvin-share";
  };

  # services.caddy.virtualHosts = lib.mkIf config.services.pingvin-share.enable {
  #   hostname = {
  #     extraConfig = ''
  #       import cfdns
  #       reverse_proxy http://localhost:${toString frontend.port}
  #     '';
  #   };
  # };
}
