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
      jellyseerr = lib.mkIf cfg.docker.jellyseerr.enable {
        autoStart = true;
        serviceName = "docker-jellyseerr";

        pull = "newer";
        # image = "ghcr.io/jellyseerr/jellyseerr:latest";
        image = "fallenbagel/jellyseerr:latest";

        ports = ["${toString listenPort}:5055"];

        # Mount your Jellyseerr config directory
        volumes = [
          "${cfg.configPath}/jellyseerr:/app/config"
        ];

        # environment = {
        #   NODE_ENV = "production";
        # Add other env vars here, e.g. email settings
        # };
      };
    };

    services.caddy.virtualHosts = lib.mkIf cfg.docker.jellyseerr.enable {
      "jellyseerr.${fqdn}" = {
        extraConfig = ''
          import cfdns
          reverse_proxy http://localhost:${toString listenPort}
        '';
      };
    };
  };
  options = {
    server.docker.jellyseerr.enable = lib.mkEnableOption "Enable jellyseerr docker container (package is kinda broken rn)";
  };
}
