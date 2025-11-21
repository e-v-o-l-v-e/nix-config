{
  lib,
  pkgs,
  config,
  username,
  ...
}: let
  cfg = config.server;
  fqdn = cfg.domain;
  listenPort = 4903;
in {
  config = {
    virtualisation.oci-containers.containers = {
      bentopdf = lib.mkIf cfg.docker.bentopdf.enable {
        autoStart = true;
        serviceName = "docker-bentopdf";

        pull = "newer";
        image = "fallenbagel/bentopdf:latest";

        ports = ["${toString listenPort}:8080"];
      };
    };

    services.caddy.virtualHosts = lib.mkIf cfg.docker.bentopdf.enable {
      "bentopdf.${fqdn}" = {
        extraConfig = ''
          import cfdns
          reverse_proxy http://localhost:${toString listenPort}
        '';
      };
    };
  };
  options = {
    server.docker.bentopdf.enable = lib.mkEnableOption "Enable bentopdf docker container";
  };
}
