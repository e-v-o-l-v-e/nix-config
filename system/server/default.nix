{
  username,
  config,
  lib,
  ...
}:
let
  cfg = config.server;
in
{
  imports = [
    ./caddy.nix
    ./jellyfin.nix
    ./jellyseerr.nix
    ./lidarr.nix
    ./local-content-share.nix
    ./network.nix
    ./opencloud.nix
    ./prowlarr.nix
    ./radarr.nix
    ./readarr.nix
    ./sonarr.nix
  ];

  config = {
    users.groups."${cfg.mediaGroupName}" = lib.mkIf cfg.enable {
      name = cfg.mediaGroupName;
      gid = cfg.mediaGroupId;
      members = [
        username
        "jellyfin"
        "radarr"
        "sonarr"
        "lidarr"
      ];
    };

    users.groups.server = {
      name = "server";
      gid = 1001;
      members = [
        username
        "jellyfin"
        "radarr"
        "sonarr"
        "lidarr"
        "opencloud"
      ];
    };

    users.users.${username}.linger = cfg.enable;
  };

  options = {
    configPath = lib.mkOption {
      type = lib.types.str;
      default = "/services-config";
      description = "path to the server's services config dir";
    };

    dataPath = lib.mkOption {
      type = lib.types.str;
      default = "/data";
      description = "path to the data dir";
    };

    mediaGroupName = lib.mkOption {
      type = lib.types.str;
      default = "media";
      description = "Nom du groupe auquel appartiendront les services media (arr stack, jellyfin etc)";
    };

    mediaGroupId = lib.mkOption {
      type = lib.types.int;
      default = 2000;
      description = "Id du groupe auquel appartiendront les services media (arr stack, jellyfin etc)";
    };
  };
}
