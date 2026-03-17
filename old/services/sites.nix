{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.server.hugo;
in {
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      hugo
    ];

    services.caddy.virtualHosts = lib.mkIf cfg.enable {
      ":1314" = {
        serverAliases = ["test-tuto.imp-network.com"];
        extraConfig = ''
          # bind 0.0.0.0
          root * /ssd/sites/tuto-tailscale/public
          file_server
        '';
      };
    };
  };

  options = {
    server.hugo.enable = lib.mkEnableOption "enable hugo";
  };
}
