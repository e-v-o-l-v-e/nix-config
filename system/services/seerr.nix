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
  version = "latest";
in {
  config = {
    virtualisation.oci-containers.containers = {
      seerr = lib.mkIf cfg.docker.seerr.enable {
	podman.user = cfg.serverGroupName;

        autoStart = true;
        serviceName = "docker-seerr";

        pull = "newer";
        image = "ghcr.io/seerr-team/seerr:${version}";

        ports = ["${toString listenPort}:5055"];
        volumes = [
          "${cfg.configPath}/seerr:/app/config"
        ];

        extraOptions = [ "--network=host" "--userns=keep-id:uid=1000,gid=1000" ];
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

    systemd.services."docker-seerr" = {
      stopIfChanged = false;
    };

  options = {
    server.docker.seerr.enable = lib.mkEnableOption "Enable seerr docker container (package is kinda broken rn)";
  };
}
