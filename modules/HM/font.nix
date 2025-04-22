{pkgs, ...}: {
  home.packages = with pkgs; [
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
