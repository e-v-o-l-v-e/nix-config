{
  flake.modules.nixos.olivetin =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      # REQUIRED MODULE : [ beets server ]

      cfg = config.server;
      fqdn = config.server.domain;
      scriptDir = cfg.dataPath + "/scripts";
      port = 1337;
    in
    {
      services.olivetin = {
        user = cfg.serverUserName;
        group = cfg.serverGroupName;

        package = pkgs.olivetin-3k;

        settings = {
          ListenAddressSingleHTTPFrontend = "0.0.0.0:${toString port}";
          actions = [
            {
              title = "Import unmapped";
              shell = "beet-import";
              icon = "󰋺";
              timeout = 3000;
            }
            {
              title = "Publish SB";
              shell = "fish ${scriptDir}/sb-public.fish > ${scriptDir}/logs/sb.log";
              icon = "🗘";
              timeout = 300;
            }
            {
              title = "Adjust Silence Level";
              icon = "🤫";
              shell = "fish ${scriptDir}/bruit.fish {{level}}";
              timeout = 300;
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
          config.beets.importPackage
          qbittorrent-cli
          sudo
        ];
      };

      security.sudo.extraRules = lib.mkIf config.services.olivetin.enable [
        {
          users = [ cfg.serverUserName ];
          commands = [
            {
              command = "/run/current-system/sw/bin/systemctl stop sonarr radarr prowlarr slskd";
              options = [ "NOPASSWD" ];
            }
            {
              command = "/run/current-system/sw/bin/systemctl start sonarr radarr prowlarr slskd";
              options = [ "NOPASSWD" ];
            }
            {
              command = "/run/current-system/sw/bin/systemctl stop qbittorrent";
              options = [ "NOPASSWD" ];
            }
            {
              command = "/run/current-system/sw/bin/systemctl start qbittorrent";
              options = [ "NOPASSWD" ];
            }
            {
              command = "/run/current-system/sw/bin/systemctl stop sonarr radarr prowlarr slskd qbittorrent";
              options = [ "NOPASSWD" ];
            }
            {
              command = "/run/current-system/sw/bin/systemctl start sonarr radarr prowlarr slskd qbittorrent";
              options = [ "NOPASSWD" ];
            }
            {
              command = "/run/current-system/sw/bin/systemctl stop jellyfin";
              options = [ "NOPASSWD" ];
            }
            {
              command = "/run/current-system/sw/bin/systemctl start jellyfin";
              options = [ "NOPASSWD" ];
            }
          ];
        }
      ];

      services.caddy.virtualHosts = lib.mkIf config.services.olivetin.enable {
        "olivetin.${fqdn}".extraConfig = ''
          import cfdns
          reverse_proxy http://localhost:${toString port}
        '';
      };
    };
}
