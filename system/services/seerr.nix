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
  version = "2.7.3";
in {
  config = {
    virtualisation.oci-containers.containers = {
      seerr = lib.mkIf cfg.docker.seerr.enable {
	# podman.user = "seerr";

        autoStart = true;
        serviceName = "docker-seerr";

        pull = "newer";
        image = "ghcr.io/fallenbagel/jellyseerr:${version}";

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

    systemd.services."docker-seerr" = {
	     stopIfChanged = false;
    };

    users.users."seerr" = {
      name = "seerr";
      createHome = true;
      home = "/var/lib/seerr"; 

      subUidRanges = [
      {
	count = 1;
	startUid = 1000;
      }
      {
	count = 65534;
	startUid = 100001;
      }
      ];
      isSystemUser = true;
      group = "seerr";
      linger = true;
    };
    users.groups.seerr = {};

    systemd.services."podman-seerr" = {
      serviceConfig = {
	RuntimeDirectory = "seerr"; # Creates /run/seerr/ owned by the user
	  RuntimeDirectoryMode = "0750";
# We must ensure the user matches the container user
	User = "seerr"; 
	Group = "seerr";
      };
    };
  };

  options = {
    server.docker.seerr.enable = lib.mkEnableOption "Enable seerr docker container (package is kinda broken rn)";
  };
}
