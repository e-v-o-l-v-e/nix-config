{
  flake.modules.nixos.olivetin =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.server;
      fqdn = config.server.domain;
      scriptDir = cfg.dataPath + "/scripts";
      port = 1337;
    in
    {
      services.olivetin = {
        user = lib.mkDefault "evolve";
        group = lib.mkDefault "users";

        package = pkgs.olivetin-3k;

        settings = {
          ListenAddressSingleHTTPFrontend = "0.0.0.0:${toString port}";
          actions = [
            {
              title = "Import unmapped";
              shell = "fish ${scriptDir}/beet-import-unmapped.fish";
              icon = "󰋺";
            }
            {
              title = "Publish SB";
              shell = "fish ${scriptDir}/sb-public.fish > ${scriptDir}/logs/sb.log";
              icon = "🗘";
            }
            {
              title = "Adjust Silence Level";
              icon = "🤫";
              shell = "fish ${scriptDir}/bruit.fish {{level}}";
              arguments = [
                {
                  name = "level";
                  type = "select";
                  choices = [
                    {
                      title = "Level 3 (Total Silence)";
                      value = "3";
                    }
                    {
                      title = "Level 2";
                      value = "2";
                    }
                    {
                      title = "Level 1";
                      value = "1";
                    }
                    {
                      title = "Level -1";
                      value = "-1";
                    }
                    {
                      title = "Level -2";
                      value = "-2";
                    }
                    {
                      title = "Level -3 (Full Power)";
                      value = "-3";
                    }
                  ];
                }
              ];
            }
            {
              title = "wake druss";
              shell = "${lib.getExe pkgs.wakeonlan} f0:2f:74:ad:7b:a6";
              icon = "󰀠 ";
            }
            {
              title = "wake new-delnoch";
              shell = "${lib.getExe pkgs.wakeonlan} 54:bf:64:73:0e:9b";
              icon = "󰀠 ";
            }
          ];
        };

        path = with pkgs; [
          fish
          beets
          qbittorrent-cli
        ];
      };

      services.caddy.virtualHosts = lib.mkIf config.services.olivetin.enable {
        "olivetin.${fqdn}".extraConfig = ''
          import cfdns
          reverse_proxy http://localhost:${toString port}
        '';
      };
    };
}
