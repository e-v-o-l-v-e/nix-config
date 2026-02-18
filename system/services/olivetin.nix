{
  config,
  lib,
  pkgs,
  username,
  ...
}: let
  cfg = config.server;
  fqdn = config.server.domain;
  scriptDir = cfg.dataPath + "/scripts";
  port = 1337;
in {
  services.olivetin = {
    user = username;
    group = "users";

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
                { title = "Level 3 (Total Silence)"; value = "3"; }
                { title = "Level 2"; value = "2"; }
                { title = "Level 1"; value = "1"; }
                { title = "Level -1"; value = "-1"; }
                { title = "Level -2"; value = "-2"; }
                { title = "Level -3 (Full Power)"; value = "-3"; }
              ];
            }
          ];
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
}
