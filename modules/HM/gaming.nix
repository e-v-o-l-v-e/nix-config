{
  pkgs,
  lib,
  hostname,
  ...
}:
lib.mkIf (hostname == "druss") {
  home.packages = with pkgs; [
    heroic-unwrapped
    steam
    steam-run
  ];
}
lib.mkIf (hostname == "waylander") {
  home.packages = with pkgs; [
    steam
  ];
}
