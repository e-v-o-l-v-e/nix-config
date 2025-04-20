{
  hostname,
  lib,
  ...
}:
lib.mkIf (hostname == "waylander") {
  imports = [
    ./hyprland.nix
    ./packages.nix
  ];
}
