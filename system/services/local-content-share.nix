{config, lib, ...}: let
  port = 8081;
in {
  imports = [../../custom/modules/local-content-share.nix];

  services.local-content-share = {
    inherit port;
  };

  services.caddy.virtualHosts = lib.mkIf config.services.silverbullet.enable {
    "quickshare.${config.server.domain}" = {
      extraConfig = ''
      reverse_proxy http://localhost:${toString port}
      '';
    };
  };
}
