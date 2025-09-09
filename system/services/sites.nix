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

    services.caddy.virtualHosts = lib.mkIf cfg.tuto-tailscale.enable {
      ":1314" = {
        serverAliases = ["http://tuto.imp-network.com"];
        extraConfig = ''
          root * /ssd/sites/caddy-site-tuto-tailscale
          file_server
        '';
      };
      "test-tuto.imp-network.com" = {
        # serverAliases = ["http://tuto.imp-network.com"];
        extraConfig = ''
          root * /ssd/sites/caddy-site-tuto-tailscale
          file_server
        '';
      };
    };
  };

  options = {
    server.hugo.enable = lib.mkEnableOption "enable hugo";
    server.hugo.tuto-tailscale.enable = lib.mkEnableOption "enable tailscaile tuto hugo site";
  };
}
