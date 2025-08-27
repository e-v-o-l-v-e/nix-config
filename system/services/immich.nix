{ config, lib , ... }: let
  cfg = config.server;
  fqdn = cfg.domain;
  immich-port = 2283;
  proxy-port = 2284;
in {
  services.immich = {
    port = immich-port;
    host = "0.0.0.0";
    mediaLocation = cfg.dataPath + "/immich";
    accelerationDevices = [ "/dev/dri/renderD128" ];
  };

  services.immich-public-proxy = {
    inherit (config.services.immich) enable; 
    port = proxy-port;
    immichUrl = "http://localhost:${toString immich-port}";
  };

  services.caddy.virtualHosts = lib.mkIf config.services.immich.enable {
    "immich.${fqdn}" = {
      extraConfig = ''
        import cfdns
        reverse_proxy http://localhost:${toString immich-port}
      '';
    };
  };
}
