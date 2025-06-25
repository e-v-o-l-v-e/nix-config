{ config, lib, ...}:let
  cfg = config.server;
  dataDir = "${cfg.configPath}/jellyfin";
in {
  services.jellyfin = {
    inherit (cfg.services.jellyfin) enable;
    inherit dataDir;
    user = "jellyfin";
    group = "media";
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
