{ lib, config, pkgs, ... }:
let
  cfg = config.server;
  fqdn = cfg.domain;

  listenPort = 3301;
  pod = "pod-spliit";
in {
  config = {
    virtualisation.oci-containers.containers = {

      docker-spliit-db = lib.mkIf cfg.docker.spliit.enable {
        autoStart = true;
        serviceName = "docker-spliit-db";

        pull = "newer";
        image = "postgres:16.3-alpine";

        extraOptions = [ "--pod=${pod}" ];

        volumes = [
          "${cfg.ssdPath}/spliit/database:/var/lib/postgresql/data"
        ];

        environmentFiles = [
          config.sops.secrets.spliit-env.path
        ];

        environment = {
          TZ = "Europe/Paris";
        };
      };

      docker-spliit = lib.mkIf cfg.docker.spliit.enable {
        autoStart = true;
        serviceName = "docker-spliit";

        pull = "newer";
        image = "crazymax/spliit:latest";

        extraOptions = [ "--pod=${pod}" ];

        dependsOn = [ "docker-spliit-db" ];

        # ports = [
        #   "${toString listenPort}:3000"
        # ];

        environmentFiles = [ config.sops.secrets.spliit-env.path ];

        environment = {
          TZ = "Europe/Paris";
          POSTGRES_HOST = "docker-spliit-db";
          POSTGRES_PORT = "5432";
        };
      };
    };

    systemd.services.create-spliit-pod = with config.virtualisation.oci-containers; {
      serviceConfig.Type = "oneshot";
      wantedBy = [ 
        "docker-spliit-db.service"
        "docker-spliit.service"
      ];
      script = ''
        ${pkgs.podman}/bin/podman pod exists ${pod} || \
        ${pkgs.podman}/bin/podman pod create -n ${pod} -p '0.0.0.0:${toString listenPort}:3000'
        '';
    };

    services.caddy.virtualHosts = lib.mkIf cfg.docker.spliit.enable {
      "spliit.${fqdn}" = {
        extraConfig = ''
          import cfdns
          reverse_proxy http://localhost:${toString listenPort}
      '';
      };
    };
  };

  options = {
    server.docker.spliit.enable = lib.mkEnableOption "Enable spliit docker container";
  };
}

