{ config, lib, ... }:
let
  cfg = config.server;
  fqdn = config.server.domain;
  
  port = 5055;
  configDir = "${cfg.configPath}/jellyseerr";
in
{
  services.jellyseerr = {
    inherit port configDir;
  };

  services.caddy.virtualHosts = lib.mkIf config.services.jellyseerr.enable {
    "jellyseerr.${fqdn}" = {
      extraConfig = ''
      reverse_proxy http://localhost:${toString port}
      '';
    };
  };
}
