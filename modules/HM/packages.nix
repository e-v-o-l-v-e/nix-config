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
        curl
        dust
        fd
        fish
        fzf
        git
        gnutar
        home-manager
        lsd
        ripgrep
        starship
        tree
        unzip
        vget
        vim
        zip
        zoxide
      ]
      ++ self.packages."${system}".my-neovim

      # packages for personnals machine
      ++ lib.mkIf (hostname == "waylander" || hostname == "druss") 
      (with pkgs; [
        element-desktop
        jellyfin-media-player
        libreoffice-qt6-fresh
        libsForQt5.kdeconnect-kde
        localsend
        nextcloud-client
        supersonic
        vesktop
      ])

      # enable zen for non-server hosts
      ++ lib.mkIf hostname != "delnoch" 
      inputs.zen-browser.packages."${system}".twilight;
  };
}
