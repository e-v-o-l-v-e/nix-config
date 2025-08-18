{
  config,
  lib,
  pkgs,
  username,
  ...
}: let
  cfg = config.server;
  fqdn = config.server.domain;
  scriptDir = cfg.configPath + "/scripts";
  port = 1337;
in {
  services.olivetin = {
    user = username;
    group = "users";

    settings = {
      actions = [
        {
          title = "Calmos frerot";
          shell = "fish ${scriptDir}/bruit.fish";
          icon = "&#128564;";
          timeout = 15;
        }
        {
          title = "relance bruit";
          shell = "fish ${scriptDir}/rebruit.fish";
          icon = "&#10515;";
          timeout = 10;
        }
        {
          title = "jeudefou cp";
          shell = "fish ${scriptDir}/jdf-cp.sh";
          icon = "🗘";
          timeout = 1;
        }
      ];
    };

    path = with pkgs; [
      fish
    ];

    services.caddy.virtualHosts = lib.mkIf config.services.olivetin.enable {
      "olivetin.${fqdn}".extraConfig = ''
        reverse_proxy http://localhost:${toString port}
        import cfdns
      '';
    };
  };
}
