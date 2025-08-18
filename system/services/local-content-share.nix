{
  config,
  lib,
  pkgs,
  ...
}: let
  port = 8081;
in {
  imports = [../../custom/modules/local-content-share.nix];

  services.local-content-share = {
    inherit port;

    package = pkgs.callPackage ../../custom/packages/local-content-share.nix { } ;
  };

  services.caddy.virtualHosts = lib.mkIf config.services.local-content-share.enable {
    "quickshare.${config.server.domain}".extraConfig = ''
      import cfdns
      reverse_proxy http://localhost:${toString port}
    '';
  };
}
