{
  lib,
  pkgs,
  config,
  username,
  ...
}: let
  cfg = config.server;
  fqdn = cfg.domain;
  listenPort = 5055;
in {
  config = {
    virtualisation.oci-containers.containers = {
      seerr = lib.mkIf cfg.docker.seerr.enable {
        autoStart = true;
        serviceName = "docker-seerr";

        pull = "newer";
        image = "fallenbagel/jellyseerr:latest";

        ports = ["${toString listenPort}:5055"];
        volumes = [
          "${cfg.configPath}/seerr:/app/config"
        ];

        extraOptions = [ "--network=host" ];
      };
    };

    services.caddy.virtualHosts = lib.mkIf cfg.docker.seerr.enable {
      "seerr.${fqdn}" = {
        extraConfig = ''
          import cfdns
          reverse_proxy http://localhost:${toString listenPort}
        '';
      };
    };
  };
  options = {
    server.docker.seerr.enable = lib.mkEnableOption "Enable seerr docker container (package is kinda broken rn)";
  };
}
