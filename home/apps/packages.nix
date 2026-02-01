{
  lib,
  pkgs,
  config,
  ...
}: {
  config = {
    home.packages = lib.mkMerge [
      (lib.optionals (config.gui.enable) (with pkgs; [
        # packages for personal machine
        blueman
        cliphist
        better-control
        # kitty
        gnome-keyring
        gparted
        libgnome-keyring
        localsend
        loupe
        pavucontrol
        ueberzugpp
        vlc
        wl-clipboard
        nautilus
        ydotool

        # theming
        flat-remix-icon-theme
      ]))
      (lib.optionals (config.personal.enable && config.gui.enable) (with pkgs;
        [
          # packages for personal machine
          element-desktop
          finamp
          jellyfin-desktop
          kdePackages.kdeconnect-kde
          libreoffice-qt6-fresh
          opencloud-desktop
          opencloud-desktop-shell-integration-dolphin
          signal-desktop
          thunderbird
          vesktop
          zathura

          # P41
          android-studio
          android-tools
        ]))
    ];

    # nixpkgs.config.permittedInsecurePackages = lib.mkIf (config.personal.enable && config.gui.enable) [
    #   "qtwebengine-5.15.19"
    # ];

    programs = {
      vesktop.enable = config.personal.enable && config.gui.enable; # need to be enabled for stylix theming to apply
      element-desktop.enable = config.personal.enable && config.gui.enable;
    };
  };
}
