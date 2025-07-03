{ config, lib, ... }:
let
  cfg = config.services.prowlarr;
  dataDir = "${cfg.configPath}/prowlarr";
in
{
  services.prowlarr = {
    inherit dataDir;

    settings = {
      update.mechanism = "external";
      server = {
        urlbase = "localhost";
        port = 9696;
        bindaddress = "*";
      };
    };
  };
  users.users.prowlarr = lib.mkIf cfg.enable {
    isSystemUser = true;
    group = cfg.mediaGroupName;
  };

  systemd.services.prowlarr = lib.mkIf cfg.enable {
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-tmpfiles-setup.service" ];
    requires = [ "systemd-tmpfiles-setup.service" ];

    serviceConfig = {
      DynamicUser = lib.mkForce false;
      User = "prowlarr";
      Group = cfg.mediaGroupName;
      ReadWritePaths = [ dataDir ];
    };
  };

  systemd.tmpfiles.rules = lib.mkIf cfg.enable [
    "d ${dataDir} 0755 prowlarr ${cfg.mediaGroupName} -"
  ];
}
