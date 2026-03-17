{ config, lib, ... }: let
  cfg = config.server;
  fqdn = cfg.domain;
  listenPort = 4000;

  version = "v1.13.4";
in {
  config = {

    virtualisation.oci-containers.containers = {
      docker-pingvin-share-x = lib.mkIf cfg.docker.pingvin-share-x.enable {
        autoStart = true;
        serviceName = "docker-pingvin-share-x";

        pull = "missing";
        image = "smp46/pingvin-share-x:${version}";

        user = "0:0";

        ports = [ "${toString listenPort}:3000" ];

        volumes = [
          "${cfg.dataPath}/pingvin-share-x:/opt/app/backend/data:rw,z"
          "${cfg.dataPath}/pingvin-share-x/images:/opt/app/frontend/public/img:rw,z"
        ];      
      };
    };

    services.caddy.virtualHosts = lib.mkIf cfg.docker.pingvin-share-x.enable {
      "share.${fqdn}" = {
        extraConfig = ''
          import cfdns
          reverse_proxy http://localhost:${toString listenPort}
        '';
      };
    };
  };

  options = {
    server.docker.pingvin-share-x.enable = lib.mkEnableOption "Enable pingvin-share-x docker container";
  };
}
