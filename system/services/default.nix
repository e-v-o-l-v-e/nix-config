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
    ./copyparty.nix
    ./jellyfin.nix
    ./jellyseerr.nix
    ./lidarr.nix
    ./local-content-share.nix
    ./network.nix
    ./opencloud.nix
    ./prowlarr.nix
    ./qbittorrent.nix
    ./radarr.nix
    ./readarr.nix
    ./silverbullet.nix
    ./sonarr.nix
  ];
}
