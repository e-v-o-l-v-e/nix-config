{ lib, config, ... }:

let
  fqdn = config.server.domain;
  cloud = {
    url = "https://cloud.${fqdn}";
    port = 9200;
  };
  collabora = {
    url = "https://collabora.${fqdn}";
    port = 9980;
  };
in {
  services.opencloud = {
    inherit (cloud) url port;
    address = "0.0.0.0";
    stateDir = "${config.server.dataPath}/opencloud";
    user = "opencloud";
    group = config.server.serverGroupName;

    environmentFile = "/services-config/opencloud-secrets.yml";

    environment = {
      OC_INSECURE = "true";
      PROXY_TLS = "false";
      COLLABORATION_APP_NAME = "CollaboraOnline";
      COLLABORATION_APP_PRODUCT = "Collabora";
      COLLABORATION_APP_ADDR = collabora.url;
      COLLABORATION_APP_ICON = "${collabora.url}/favicon.ico";
      COLLABORATION_APP_INSECURE = "true";
      COLLABORATION_WOPI_SRC = collabora.url;
      OC_URL = cloud.url;
    };

    settings = {
      app-registry = {
        apps = [
          {
            name = "Collabora";
            description = "Collabora Online";
            route = "/apps/collabora";
            wopi_url = collabora.url;
            open_mode = "external";
          }
        ];
      };
      web = {
        web = {
          config = {
            office = {
              enable = true;
              wopi_url = collabora.url;
            };
          };
        };
      };
    };
  };

  services.collabora-online = {
    enable = false;
    port = collabora.port;
    settings = {
      storage = {
        wopi = {
          "@allow" = true;
        };
      };
      net = {
        frame_ancestors = "cloud.${fqdn}";
        post_allow = {
          host = [ "127\\.0\\.0\\.1" "::1" "cloud.${fqdn}" ];
        };
      };
      ssl = {
        enable = false;
      };
    };
    aliasGroups = [
      {
        host = cloud.url;
        aliases = [ "cloud.${fqdn}" ];
      }
    ];
    extraArgs = [ "--o:ssl.enable=false" ];
  };

  services.caddy.virtualHosts = lib.mkIf config.services.opencloud.enable {
    "${cloud.url}" = {
      extraConfig = ''
        import cfdns
        reverse_proxy http://localhost:${toString cloud.port}
        encode gzip
      '';
    };

    "${collabora.url}" = lib.mkIf config.services.collabora-online.enable {
      extraConfig = ''
        import cfdns
        reverse_proxy http://localhost:${toString collabora.port} {
          header_up Host {host}
          header_up X-Real-IP {remote}
          header_up X-Forwarded-For {remote}
          header_up X-Forwarded-Proto {scheme}
        }
      '';
    };
  };
}
