{
  flake.modules.nixos.tidarr =
    { config, lib, ... }:
    let
      cfg = config.server;
      fqdn = cfg.domain;
      listenPort = 8484;
    in
    {
      config = {
        virtualisation.oci-containers.containers = {
          tidarr = lib.mkIf config.server.docker.tidarr.enable {
            autoStart = true;
            serviceName = "podman-tidarr";
            pull = "newer";
            image = "cstaelen/tidarr";
            user = "${toString cfg.serverUserId}:${toString cfg.serverGroupId}";
            ports = [ "${toString listenPort}:8484" ];
            volumes = [
              "${cfg.configPath}/tidarr:/shared"
              "${cfg.dataPath}/media/music/:${cfg.dataPath}/media/music/"
              "${cfg.dataPath}/media/music-unmapped/:${cfg.dataPath}/media/music-unmapped/"
            ];
          };
        };

        services.caddy.virtualHosts."tidarr.${fqdn}".extraConfig = ''
          import cfdns
          reverse_proxy http://localhost:${toString listenPort}
        '';
      };

      options.server.docker.tidarr.enable = lib.mkEnableOption "Tidarr docker container";
    };
}
