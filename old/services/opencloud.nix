{
  lib,
  config,
  ...
}: let
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
  config.services = {
    opencloud = {
      inherit (cloud) url port;
      address = "0.0.0.0";
      stateDir = "${config.server.dataPath}/opencloud";
      user = "opencloud";
      group = config.server.serverGroupName;

      environmentFile = "/services-config/opencloud-secrets.yml";

      environment = {
        OC_INSECURE = "true";
        PROXY_TLS = "false";
        OC_URL = cloud.url;
      };
    };

    collabora-online = {
      enable = false;
      inherit (collabora) port;
      settings = {
        storage = {
          wopi = {
            "@allow" = true;
          };
        };
        net = {
          frame_ancestors = "cloud.${fqdn}";
          post_allow = {
            host = ["127\\.0\\.0\\.1" "::1" "cloud.${fqdn}"];
          };
        };
        ssl = {
          enable = false;
        };
      };
      aliasGroups = [
        {
          host = cloud.url;
          aliases = ["cloud.${fqdn}"];
        }
      ];
      extraArgs = ["--o:ssl.enable=false"];
    };

    caddy.virtualHosts = lib.mkIf config.services.opencloud.enable {
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
  };
}
