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

  silence = level: {
    title = "silence ${toString level}";
    shell = "fish ${scriptDir}/bruit.fish ${toString level}";
    icon = (toString level);
    timeout = 5;
  };
in {
  services.olivetin = {
    user = username;
    group = "users";

    settings = {
      ListenAddressSingleHTTPFrontend = "0.0.0.0:${toString port}";
      actions = [
        {
          title = "import unmapped";
          shell = "fish ${scriptDir}/beet-import-unmapped.fish";
          icon = "󰋺";
          timeout = 5;
        }
        {
          title = "publish sb";
          shell = "fish ${scriptDir}/sb-public.fish > ${scriptDir}/logs/sb.log";
          icon = "🗘";
          timeout = 5;
        }
        (silence (-3))
        (silence (-2))
        (silence (-1))
        (silence (1))
        (silence (2))
        (silence (3))
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
