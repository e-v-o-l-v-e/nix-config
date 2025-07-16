{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    carlito
    noto-fonts
    noto-fonts-cjk-sans
    fira-code
    fira-code-symbols
    nerd-fonts.fira-code
    nerd-fonts.terminess-ttf
    victor-mono
    nerd-fonts.daddy-time-mono
    fantasque-sans-mono
    jetbrains-mono
    font-awesome
    fira
  ];
}
