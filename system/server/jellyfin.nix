{ config, ...}:let
  cfg = config.server;
in {
  services.jellyfin = {
    inherit (cfg.services.jellyfin) enable;
    dataDir = "${cfg.configPath}/jellyfin";
  };

  # systemd.tmpfiles.rules = lib.mkIf cfg.enable [ 
  #   "d ${cfg.configPath}/jellyfin 770 jellyfin - -" 
  #   "Z ${cfg.configPath}/jellyfin 770 jellyfin - -" 
  #   "d ${cfg.dataPath}/config/jellyfin 770 jellyfin - -" 
  #   "Z ${cfg.dataPath}/jellyfin 770 jellyfin - -" 
  # ];
}
