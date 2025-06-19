{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    carlito
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
    enable = lib.mkForce false;
    defaultFonts = {
      monospace = [ "daddy-time-mono" ];
    };
  };
}
