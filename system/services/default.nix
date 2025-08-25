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
    ./immich.nix
    ./kavita.nix
    ./local-content-share.nix
    ./olivetin.nix
    ./opencloud.nix
    ./qbittorrent.nix
    ./silverbullet.nix
    ./slskd.nix
  ];
}
