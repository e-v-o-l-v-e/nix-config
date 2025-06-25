{ config, lib, ... }:
let
  cfg = config.server;
  dataDir = "${cfg.configPath}/prowlarr";
  inherit (cfg.services.prowlarr) enable;
in
{
  services.prowlarr = {
    inherit enable dataDir;
    settings = {
      update.mechanism = "external";
      server = {
        urlbase = "localhost";
        port = 9696;
        bindaddress = "*";
      };
    };
  };
  users.users.prowlarr = lib.mkIf enable {
    isSystemUser = true;
    group = cfg.mediaGroupName;
    # home = "/var/lib/media";
  };

  systemd.services.prowlarr = lib.mkIf enable {
    serviceConfig = {
      DynamicUser = lib.mkForce false;
      User = "prowlarr";
      Group = cfg.mediaGroupName;
      ReadWritePaths = [ dataDir ];
    };
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-tmpfiles-setup.service" ];
    requires = [ "systemd-tmpfiles-setup.service" ];
  };

  systemd.tmpfiles.rules = lib.mkIf enable [ "d ${dataDir} 0755 prowlarr ${cfg.mediaGroupName} -" ];
}
