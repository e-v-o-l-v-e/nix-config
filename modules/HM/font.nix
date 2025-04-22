{
  pkgs,
  lib,
  hostname,
  ...
}:
lib.mkIf (hostname == "waylander" || hostname == "druss") {
  home.packages = with pkgs; [
    noto-fonts
    fira-code
    terminus_font
    victor-mono
    nerd-fonts.daddy-time-mono
    fantasque-sans-mono
    jetbrains-mono
    font-awesome
    fira
  ];

  fonts.fontconfig = {
    defaultFonts = {
      monospace = ["daddy-time-mono"];
    };
  };
}
