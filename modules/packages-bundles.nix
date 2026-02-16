{ pkgs, self, ... }:
{
  flake.modules.homeManager = {
    cli-personal = {
      home.packages = with pkgs; [
        cava
        discordo
        jellyfin-tui
        lowfi
        presenterm
        sops
      ];
    };

    cli-nvim = {
      home.packages = with pkgs; [
        neovim
        fish-lsp
        # lua
        lua5_1
        luarocks
        lua-language-server
        tree-sitter
        # tree-sitter-grammars.tree-sitter-norg
      ];
    };

    cli-nix = {
      home.packages = with pkgs; [
        alejandra
        nh
        nil
        nixd
        nixfmt
      ];
    };

    gui-common = {
      home.packages = with pkgs; [
        blueman
        cliphist
        kitty
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
      ];
    };

    gui-personnal = {
      home.packages = with pkgs; [
        element-desktop
        finamp
        jellyfin-desktop
        kdePackages.kdeconnect-kde
        libreoffice-qt6-fresh
        opencloud-desktop
        opencloud-desktop-shell-integration-dolphin
        thunderbird
        vesktop
        zathura
      ];
    };
  };
}
