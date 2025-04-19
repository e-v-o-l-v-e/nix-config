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

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
# simpler gaming config
lib.mkIf (hostname == "waylander") {
  home.packages = with pkgs; [
    steam
  ];
}
