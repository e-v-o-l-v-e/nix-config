{
  lib,
  config,
  ...
}: let
  cfg = config.server;

  listenPort = 3333;
  listenPortPublic = 3334;
  fqdn = cfg.domain;
in {
  config = {
    virtualisation.oci-containers.containers = {
      docker-silverbullet = lib.mkIf cfg.docker.silverbullet.enable {
        autoStart = true;
        serviceName = "docker-silverbullet";

        pull = "newer";
        image = "ghcr.io/silverbulletmd/silverbullet:v2";

        ports = ["${toString listenPort}:3000"];

        volumes = [
          "${cfg.ssdPath}/silverbullet/space:/space"
        ];

        # environment = {
        #   already the default with docker
        #   SB_HOSTNAME = "0.0.0.0";
        # };

        environmentFiles = [
          config.sops.secrets.silverbullet-env.path
        ];
      };

      docker-silverbullet-public = lib.mkIf cfg.docker.silverbullet-public.enable {
        autoStart = true;
        serviceName = "docker-silverbullet-public";

        pull = "newer";
        image = "ghcr.io/silverbulletmd/silverbullet:v2";

        ports = ["${toString listenPortPublic}:3000"];

        volumes = [
          "${cfg.ssdPath}/silverbullet/public:/space"
        ];

        environment = {
          #SB_HOSTNAME = "0.0.0.0"; #  already the default with docker
          SB_READ_ONLY = "true";
        };
      };
    };

    services.caddy.virtualHosts = lib.mkIf (config.services.silverbullet.enable || cfg.docker.silverbullet.enable) {
      "silverbullet.${fqdn}" = {
        extraConfig = ''
          import cfdns
          reverse_proxy http://localhost:${toString listenPort}
        '';
      };
    };
  };

  options = {
    server.docker.silverbullet.enable = lib.mkEnableOption "Enable silverbullet docker container (package is kinda broken rn)";
    server.docker.silverbullet-public.enable = lib.mkEnableOption "Enable read-only silverbuller instance";
  };
}
