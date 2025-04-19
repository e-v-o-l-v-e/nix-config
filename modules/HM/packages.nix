{
  hostname,
  lib,
  pkgs,
  self,
  system,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should manage.
  home = {
    # The home.packages option allows you to install Nix packages into your environment.
    packages = with pkgs;
    # common packages for all hosts
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
        home-manager
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
        vget
        vim
        wl-clipboard
        zip
        zoxide
      ]
      ++ self.packages."${system}".my-neovim
      # packages for personnals machine
      ++ lib.mkIf (hostname == "waylander" || hostname == "druss")
      (with pkgs; [
        element-desktop
        imagemagick
        jellyfin-media-player
        jq
        libnotify
        libreoffice-qt6-fresh
        libsForQt5.kdeconnect-kde
        localsend
        nextcloud-client
        supersonic
        thunar
        vesktop
        xdg-user-dirs
        xdg-utils
      ])
      # enable zen for non-server hosts
      ++ lib.mkIf (hostname != "delnoch")
      inputs.zen-browser.packages."${system}".twilight;
  };
}
