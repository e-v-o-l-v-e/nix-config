{
  flake.modules.nixos.immich =
    { config, lib, pkgs, ... }:
    let
      cfg = config.server;
      fqdn = cfg.domain;
      immich-port = 2283;
      proxy-port = 2284;
    in
    {
      services.immich = {
        port = immich-port;
        host = "0.0.0.0";
        mediaLocation = "${cfg.dataPath}/immich";
        accelerationDevices = [ "/dev/dri/renderD128" ];
      };

      services.immich-public-proxy = {
        inherit (config.services.immich) enable;
        port = proxy-port;
        immichUrl = "http://localhost:${toString immich-port}";
      };

      systemd.services.immich-collation-refresh = {
        description = "Refresh immich PostgreSQL collation version";
        after = [ "postgresql.service" ];
        wantedBy = [ "multi-user.target" ];
        path = [ config.services.postgresql.package ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          User = "immich";
        };
        script = ''
          psql immich -c "ALTER DATABASE immich REFRESH COLLATION VERSION;"
        '';
      };

      services.caddy.virtualHosts = lib.mkIf config.services.immich.enable {
        "immich.${fqdn}".extraConfig = ''
          import cfdns
          reverse_proxy http://localhost:${toString immich-port}
        '';
        "immich.ts.${fqdn}".extraConfig = ''
          import cfdns
          reverse_proxy http://localhost:${toString immich-port}
        '';
      };
    };
}
