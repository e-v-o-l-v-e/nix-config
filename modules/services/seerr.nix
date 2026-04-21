{
  flake.modules.nixos.seerr =
    { config, lib, ... }:
    let
      cfg = config.server;
      fqdn = cfg.domain;
      listenPort = 5055;
      version = "latest";
    in
    {
      config = {
        virtualisation.oci-containers.containers = {
          seerr = lib.mkIf cfg.docker.seerr.enable {
            autoStart = true;
            pull = "newer";
            image = "ghcr.io/seerr-team/seerr:${version}";
            ports = [ "${toString listenPort}:5055" ];
            volumes = [ "${cfg.configPath}/seerr:/app/config" ];
            user = "986:988";
            extraOptions = [ "--network=host" ];
          };
        };

        services.caddy.virtualHosts = lib.mkIf cfg.docker.seerr.enable {
          "seerr.${fqdn}".extraConfig = ''
            import cfdns
            reverse_proxy http://localhost:${toString listenPort}
          '';
        };

        systemd.services."podman-seerr".stopIfChanged = false;

        users.users.seerr = {
          name = "seerr";
          createHome = true;
          home = "/var/lib/seerr";
          subUidRanges = [
            { count = 1; startUid = 1000; }
            { count = 65534; startUid = 100001; }
          ];
          isSystemUser = true;
          group = "seerr";
          linger = true;
        };
        users.groups.seerr = { };

      };

      options.server.docker.seerr.enable = lib.mkEnableOption "jellyseerr docker container";
    };
}
