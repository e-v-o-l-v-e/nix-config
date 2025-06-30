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
}
