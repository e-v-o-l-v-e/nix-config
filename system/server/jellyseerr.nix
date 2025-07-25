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

  services.caddy.virtualHosts."jellyseerr.${fqdn}" = {
    extraConfig = ''
      reverse_proxy http://localhost:${toString port}
    '';
  };

  # users.users.jellyseerr = lib.mkIf cfg.services.jellyseerr.enable {
  #   isSystemUser = true;
  #   group = cfg.mediaGroupName;
  #   # home = "/var/lib/media";
  # };
  #
  # systemd.services.jellyseerr = lib.mkIf cfg.services.jellyseerr.enable {
  #   serviceConfig = {
  #     DynamicUser = lib.mkForce false;
  #     User = "jellyseerr";
  #     Group = "media";
  #     ReadWritePaths = [ configDir ];
  #   };
  #   wantedBy = [ "multi-user.target" ];
  #   after = [ "systemd-tmpfiles-setup.service" ];
  #   requires = [ "systemd-tmpfiles-setup.service" ];
  # };
  #
  # systemd.tmpfiles.rules = lib.mkIf cfg.services.jellyseerr.enable [ 
  #   "d ${configDir} 0755 jellyseerr media -" 
  #   "Z ${configDir} 0755 jellyseerr media" 
  # ];
}
