{
  flake.modules.nixos.silverbullet =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.server;
      fqdn = cfg.domain;

      listenPort = 3333;
      listenPortPublic = 3334;
      listenPortPublicEdit = 3335;
      version = "latest";
    in
    {
      config = {
        virtualisation.oci-containers.containers = {
          docker-silverbullet = lib.mkIf cfg.docker.silverbullet.enable {
            autoStart = true;
            serviceName = "docker-silverbullet";
            pull = "newer";
            image = "zefhemel/silverbullet:${version}";
            ports = [ "${toString listenPort}:3000" ];
            volumes = [ "${cfg.ssdPath}/silverbullet/space:/space" ];
            environmentFiles = [ config.sops.secrets.silverbullet-env.path ];
          };

          docker-silverbullet-public = lib.mkIf cfg.docker.silverbullet-public.enable {
            autoStart = true;
            serviceName = "docker-silverbullet-public";
            pull = "newer";
            image = "zefhemel/silverbullet:${version}";
            ports = [ "${toString listenPortPublic}:3000" ];
            volumes = [ "${cfg.ssdPath}/silverbullet/public:/space" ];
            environment = {
              SB_READ_ONLY = "true";
              SB_INDEX_PAGE = "index-public";
            };
          };

          docker-silverbullet-public-edit = lib.mkIf cfg.docker.silverbullet-public.enable {
            autoStart = false;
            serviceName = "docker-silverbullet-public-edit";
            pull = "newer";
            image = "zefhemel/silverbullet:${version}";
            ports = [ "${toString listenPortPublicEdit}:3000" ];
            volumes = [ "${cfg.ssdPath}/silverbullet/public:/space" ];
            environment = {
              SB_INDEX_PAGE = "index-public";
            };
          };
        };

        services.caddy.virtualHosts =
          lib.mkIf (config.services.silverbullet.enable or false || cfg.docker.silverbullet.enable)
            {
              "sbe.${fqdn}".extraConfig = ''
                import cfdns
                reverse_proxy http://localhost:${toString listenPortPublicEdit}
              '';
            };

        systemd.timers."sb-publish" = {
          timerConfig = {
            OnCalendar = "01:00:00";
            Unit = "sb-publish.service";
          };
        };
        systemd.services."sb-publish" = {
          script = "${pkgs.fish}/bin/fish ${cfg.dataPath}/scripts/sb-public.fish > ${cfg.dataPath}/scripts/logs/sb.log";
          serviceConfig = {
            Type = "oneshot";
            User = "evolve";
          };
        };
      };

      options.server.docker = {
        silverbullet.enable = lib.mkEnableOption "silverbullet docker container";
        silverbullet-public.enable = lib.mkEnableOption "read-only silverbullet instance";
      };
    };
}
