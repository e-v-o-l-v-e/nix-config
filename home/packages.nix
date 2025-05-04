{
  lib,
  pkgs,
  self,
  system,
  personal,
  nvfConfig,
  ...
}:
{
  home = {
    packages =
      with pkgs; # common packages for all hosts

      [
        bat
        btop
        cliphist
        curl
        dust
        fd
        fish
        fzf
        git
        gnutar
        loupe
        lsd
        networkmanager
        nixd
        pamixer
        pavucontrol
        pciutils
        playerctl
        ripgrep
        starship
        tree
        unzip
        wget
        vim
        wl-clipboard
        zip
        zoxide
      ]
      ++ [ self.packages."${system}".nvf-max ]
      # packages for personal machine
      ++ lib.optionals personal (
        with pkgs;
        [
          blueman
          element-desktop
          imagemagick
          jellyfin-media-player
          jq
          kitty
          libnotify
          libreoffice-qt6-fresh
          libsForQt5.kdeconnect-kde
          localsend
          nextcloud-client
          supersonic
          xfce.thunar
          vesktop
          xdg-user-dirs
          xdg-utils

          # theming
          flat-remix-icon-theme
        ]
      );
  };

  programs = {
    vesktop.enable = personal;
    element-desktop.enable = personal;
    btop.enable = personal;
    cava.enable = personal;

  };
}
