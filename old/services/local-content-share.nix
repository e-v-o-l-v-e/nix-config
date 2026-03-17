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
  services.local-content-share = {
    inherit port;
  };

  services.caddy.virtualHosts = lib.mkIf config.services.local-content-share.enable {
    "quickshare.${config.server.domain}".extraConfig = ''
      import cfdns
      reverse_proxy http://localhost:${toString port}
    '';
  };
}
