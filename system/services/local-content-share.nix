{
  config,
  lib,
  pkgs,
  system,
  inputs,
  ...
}: let
  port = 8081;
in {
  imports = [
    # ../../custom/modules/local-content-share.nix
    inputs.local-content-share.nixosModules.local-content-share
  ];

  services.local-content-share = {
    enable = true;
    inherit port;

    # package = pkgs.callPackage ../../custom/packages/local-content-share.nix { } ;
    # package = inputs.local-content-share.packages.${pkgs.system}.local-content-share;
  };

  services.caddy.virtualHosts = lib.mkIf config.services.local-content-share.enable {
    "quickshare.${config.server.domain}".extraConfig = ''
      import cfdns
      reverse_proxy http://localhost:${toString port}
    '';
  };
}
