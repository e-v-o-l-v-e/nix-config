{config, ...}: let
  cfg = config.server;
  dataDir = "${cfg.configPath}/jellyfin";
  fqdn = config.server.domain;
in {
  services.jellyfin = {
    inherit dataDir;
    user = "jellyfin";
    group = "media";
  };

  services.caddy.virtualHosts."jellyfin.${fqdn}" = {
    extraConfig = ''
      reverse_proxy http://localhost:8096
    '';
  };

  # systemd.services.jellyfin = {
  #   serviceConfig = {
  #     DynamicUser = lib.mkForce false;
  #     User = "jellyfin";
  #     Group = "media";
  #     ReadWritePaths = [ dataDir ];
  #   };
  #   wantedBy = [ "multi-user.target" ];
  #   after = [ "systemd-tmpfiles-setup.service" ];
  #   requires = [ "systemd-tmpfiles-setup.service" ];
  # };

  # systemd.tmpfiles.rules = [
  #   "d ${dataDir} 0755 jellyseerr media -"
  #   "Z ${dataDir} 0755 jellyseerr media"
  # ];

  # systemd.tmpfiles.rules = lib.mkIf cfg.enable [
  #   "d ${cfg.configPath}/jellyfin 770 jellyfin - -"
  #   "Z ${cfg.configPath}/jellyfin 770 jellyfin - -"
  #   "d ${cfg.dataPath}/config/jellyfin 770 jellyfin - -"
  #   "Z ${cfg.dataPath}/jellyfin 770 jellyfin - -"
  # ];
}
