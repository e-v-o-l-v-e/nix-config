{
  lib,
  config,
  ...
}: let
  cfg = config.server;
  fqdn = cfg.domain;

  port = 9200;
  url = "https://cloud.${fqdn}";

  co-port = 9980;
in {
  services.opencloud = {
    inherit url port;
    stateDir = "${config.server.dataPath}/opencloud";
    # address = "0.0.0.0";
    user = "opencloud";
    group = cfg.serverGroupName;
    environment = {
      OC_INSECURE = "true";
      PROXY_TLS = "false";
      OC_USERNAME = "admin";
      OC_PASSWORD = "admin";
      # IDM_ADMIN_PASSWORD = "admin";
      # ADMIN_PASSWORD = "admin";
    };
    environmentFile = "/services-config/opencloud.yml";
  };

  services.collabora-online = {
    enable = false;
    # inherit (config.services.opencloud) enable;

    port = co-port;

    settings = {
      storage.wopi."@allow" = true;
      # ssl = {
      #   enable = false;
      #   termination = false;
      # };
    };

    aliasGroups = [{
      host = url;
    }];
  };

  services.caddy.virtualHosts = lib.mkIf config.services.opencloud.enable {
    "${url}" = {
      extraConfig = ''
        import cfdns
        reverse_proxy http://localhost:${toString port}
      '';
    };

    # "collabora.${fqdn}" = {
    #   extraConfig = ''
    #     import cfdns
    #     reverse_proxy http://localhost:${toString co-port}
    #   '';
    # };
  };
}
