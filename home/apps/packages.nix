{
  lib,
  pkgs,
  config,
  ...
}:
{
  config = {
    home.packages = lib.mkMerge [
      (lib.optionals (config.gui.enable) (with pkgs; [
        # packages for personal machine
        blueman
        cliphist
        # kitty
        localsend
        loupe
        pavucontrol
        ueberzugpp
        vlc
        wl-clipboard
        xfce.thunar

        # theming
        flat-remix-icon-theme
      ]))
      (lib.optionals (config.personal.enable && config.gui.enable) (with pkgs; [
        # packages for personal machine
        element-desktop
        finamp
        jellyfin-media-player
        kdePackages.kdeconnect-kde
        libreoffice-qt6-fresh
        nextcloud-client
        thunderbird
        vesktop
      ]))
    ];

    programs = {
      vesktop.enable = config.personal.enable && config.gui.enable; # need to be enabled for stylix theming to apply
      element-desktop.enable = config.personal.enable && config.gui.enable;
    };
  };
}
