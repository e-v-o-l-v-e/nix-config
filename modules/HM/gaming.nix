{
  pkgs,
  lib,
  hostname,
  ...
}:
# battlestation gaming config
lib.mkIf (hostname == "druss") {
  home.packages = with pkgs; [
    heroic-unwrapped
    steam
    steam-run
  ];
}
# simpler gaming config
lib.mkIf (hostname == "waylander") {
  home.packages = with pkgs; [
    steam
  ];
}
