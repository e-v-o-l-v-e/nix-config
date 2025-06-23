{ username, config, lib, ... }:
let
  cfg = config.server;
in
{
  imports = [
    ./caddy.nix
    ./jellyfin.nix
    ./opencloud.nix
    ./radarr.nix
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
    ];
  };

  users.users.${username}.linger = cfg.enable;
}
