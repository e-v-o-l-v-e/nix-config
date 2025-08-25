{ config, lib , ... }: let
  cfg = config.server;
  fqdn = cfg.domain;
  port = 2283;
in {
  services.immich = {
    inherit port;
    host = "0.0.0.0";
    mediaLocation = cfg.dataPath + "/immich";
    accelerationDevices = [ "/dev/dri/renderD128" ];
  };

  services.caddy.virtualHosts = lib.mkIf config.services.immich.enable {
    "immich.${fqdn}" = {
      extraConfig = ''
        import cfdns
        reverse_proxy http://localhost:${toString port}
      '';
    };
  };
}
