{
  lib,
  pkgs,
  config,
  username,
  ...
}: let
  cfg = config.server;
  fqdn = cfg.domain;
  scriptDir = cfg.dataPath + "/scripts";

  listenPort = 3333;
  listenPortPublic = 3334;
  version = "v2";
in {
  config = {
    virtualisation.oci-containers.containers = {
      docker-silverbullet = lib.mkIf cfg.docker.silverbullet.enable {
        autoStart = true;
        serviceName = "docker-silverbullet";

        pull = "newer";
        image = "zefhemel/silverbullet:${version}";

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
        # image = "ghcr.io/silverbulletmd/silverbullet:v2";
        image = "zefhemel/silverbullet:${version}";

        ports = ["${toString listenPortPublic}:3000"];

        volumes = [
          "${cfg.ssdPath}/silverbullet/public:/space"
        ];

        environment = {
          #SB_HOSTNAME = "0.0.0.0"; #  already the default with docker
          SB_READ_ONLY = "true";
          SB_INDEX_PAGE = "index-public";
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

    systemd.timers."sb-publish" = {
      timerConfig = {
        OnCalendar = "01:00:00";
        Unit = "sb-publish.service";
      };
    };
    systemd.services."sb-publish" = {
      script = "${pkgs.fish}/bin/fish ${scriptDir}/sb-public.fish > ${scriptDir}/logs/sb.log";
      serviceConfig = { 
        Type = "oneshot";
        User = username;
      };
    };
  };

  options = {
    server.docker.silverbullet.enable = lib.mkEnableOption "Enable silverbullet docker container (package is kinda broken rn)";
    server.docker.silverbullet-public.enable = lib.mkEnableOption "Enable read-only silverbuller instance";
  };
}
