{
  lib,
  pkgs,
  self,
  system,
  personal,
  ...
}:
{
  home = {
    packages =
      with pkgs; # common packages for all hosts

      [
        bat
        btop
        curl
        dust
        duf
        fd
        fish
        fzf
        git
        gitui
        gnutar
        lsd
        networkmanager
        nixd
        pciutils
        playerctl
        ripgrep
        starship
        tmux
        trashy
        tree
        unzip
        wget
        vim
        zip
        zoxide
      ]
      ++ [ self.packages."${system}".nvf-max ]
      # packages for personal machine
      ++ lib.optionals personal (
        with pkgs;
        [
          blueman
          cliphist
          element-desktop
          finamp
          imagemagick
          jellyfin-media-player
          jq
          kitty
          libnotify
          libreoffice-qt6-fresh
          libsForQt5.kdeconnect-kde
          localsend
          lowfi
          loupe
          nextcloud-client
          pamixer
          pavucontrol
          presenterm
          ripgrep-all
          wl-clipboard
          xfce.thunar
          vesktop
          vlc
          xdg-user-dirs
          xdg-utils
          zellij

          # theming
          flat-remix-icon-theme
        ]
      );
  };

  programs = {
    vesktop.enable = personal;
    element-desktop.enable = personal;
    btop.enable = true;
    cava.enable = personal;
    fd.enable = true;
  };
}
