{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # dotfiles management
    stow

    # gtk
    dconf
    adwaita-icon-theme
    adwaita-fonts
    adwaita-qt
    gtk4
    gtk3

    # fonts
    carlito
    # fira
    # fira-code
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    font-awesome
    jetbrains-mono
    monoid
    nerd-fonts.jetbrains-mono
    nerd-fonts.daddy-time-mono
    nerd-fonts.symbols-only
    noto-fonts
    victor-mono
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = ["FiraCode Nerd Font Mono" "DaddyTime Nerd Font Mono"];
    };
  };
}
