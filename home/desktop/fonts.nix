{ pkgs, ... }:
{
  home.packages = with pkgs; [
    carlito
    fira
    fira-code
    font-awesome
    jetbrains-mono
    monoid
    nerd-fonts.daddy-time-mono
    noto-fonts
    victor-mono
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "FiraCode Nerd Font Mono" "DaddyTime Nerd Font Mono" ];
    };
  };
}
