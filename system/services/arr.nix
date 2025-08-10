{ config, lib, ... }:
let
  cfg = config.server;

  arrServices = [
    { name = "lidarr";    port = 8686; }
    { name = "prowlarr";  port = 9696; }
    { name = "radarr";    port = 7878; }
    { name = "readarr";   port = 8787; }
    { name = "sonarr";    port = 8989; }
  ];

  mkArrService = { name, port, extraUser ? false }:
    let
      fqdn = cfg.domain;
      dataDir = "${cfg.configPath}/${name}";
    in {
      services.${name} = {
        inherit dataDir;
        settings = {
          update.mechanism = "external";
          server = {
            inherit port;
            urlbase = "localhost";
            bindaddress = "*";
          };
        };
      } // lib.optionalAttrs (name != "prowlarr") {
        group = cfg.mediaGroupName;
      };

      services.caddy.virtualHosts."${name}.${fqdn}" = {
        extraConfig = ''
          reverse_proxy http://localhost:${toString port}
          tls {
            dns cloudflare {env.CLOUDFLARE_API_TOKEN}
            resolvers 1.1.1.1
          }
        '';
      };
    };
in
  lib.mkMerge (map mkArrService arrServices)
