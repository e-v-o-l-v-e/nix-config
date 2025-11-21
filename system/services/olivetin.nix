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
          title = "publish sb";
          shell = "fish ${scriptDir}/sb-public.fish > ${scriptDir}/logs/sb.log";
          icon = "🗘";
          timeout = 5;
        }
        {
          title = "import unmapped";
          shell = "fish ${scriptDir}/beet-import-unmapped.fish";
          # shell = "fish /data/scripts/beet-import-unmapped.fish";
          icon = "󰋺";
          timeout = 5;
        }
      ];
    };

    path = with pkgs; [
      fish
      beets
    ];
  };

  services.caddy.virtualHosts = lib.mkIf config.services.olivetin.enable {
    "olivetin.${fqdn}".extraConfig = ''
      import cfdns
      reverse_proxy http://localhost:${toString port}
    '';
  };
}
