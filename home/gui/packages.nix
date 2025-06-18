{
  lib,
  pkgs,
  hostConfig,
  ...
}:
{
  home.packages = lib.optionals (hostConfig.personal.enable) (with pkgs; [
      # packages for personal machine
      blueman
      cliphist
      element-desktop
      finamp
      jellyfin-media-player
      kitty
      libreoffice-qt6-fresh
      libsForQt5.kdeconnect-kde
      localsend
      loupe
      nextcloud-client
      pavucontrol
      wl-clipboard
      xfce.thunar
      vesktop
      vlc
      xdg-user-dirs
      zellij

      # theming
      flat-remix-icon-theme
    ]
  );

  programs = {
    vesktop.enable = hostConfig.personal.enable;
    element-desktop.enable = hostConfig.personal.enable;
  };
}
