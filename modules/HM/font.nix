{pkgs, ...}: {
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
    enable = true;
    defaultFonts = {
      monospace = ["daddy-time-mono"];
    };
  };
}
