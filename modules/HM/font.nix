{
  pkgs,
  lib,
  hostname,
  ...
}:
lib.mkIf (hostname == "waylander" || hostname == "druss") {
  home.packages = with pkgs; [
    DaddyTimeMono
    FantasqueSansMono
    nerdfonts.jetbrains-mono
    font-awesome
    fira
  ];
}
