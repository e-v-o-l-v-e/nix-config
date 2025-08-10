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
    ./arr.nix
    ./caddy.nix
    ./copyparty.nix
    ./jellyfin.nix
    ./jellyseerr.nix
    ./local-content-share.nix
    ./opencloud.nix
    ./qbittorrent.nix
    ./silverbullet.nix
  ];
}
