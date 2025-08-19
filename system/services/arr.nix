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

  mkArrService = { name, port, }:
    let
      fqdn = cfg.domain;
      dataDir = "${cfg.configPath}/${name}";
    in {
      services.${name} = {
        settings = {
          update.mechanism = "external";
          server = {
            inherit port;
            urlbase = "localhost";
            bindaddress = "*";
          };
        };
      } // lib.optionalAttrs (name != "prowlarr") {
        inherit dataDir;
        group = cfg.serverGroupName;
        user = cfg.serverUserName;
      };

      services.caddy.virtualHosts = lib.mkIf config.services."${name}".enable {
        "${name}.${fqdn}" = {
          extraConfig = ''
            reverse_proxy http://localhost:${toString port}
            import cfdns
          '';
        };
      };


      systemd.services."${name}".serviceConfig.UMask = "0002";
    };
in
  lib.mkMerge (map mkArrService arrServices)
