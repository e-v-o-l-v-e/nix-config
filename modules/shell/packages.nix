{ pkgs, self, ... }:
{
  flake.modules.homeManager = {
    cli-core = {
      home.packages = with pkgs; [
        bat
        btop
        curl
        dust
        fd
        git
        gnutar
        lsd
        openssh
        ripgrep
        tree
        unzip
        vim
        wget
        zip
      ];
    };

    cli-utils = {
      home.packages = with pkgs; [
        calc
        duf
        fastfetch
        fzf
        imagemagick
        jq
        libnotify
        linux-manual
        man-pages
        man-pages-posix
        openssl
        pciutils
        playerctl
        trashy
        xdg-utils
        yazi
      ];
    };

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
        alejandra
        fish-lsp
        # lua
        lua-language-server
        lua5_1
        luarocks
        neovim
        nil
        nixd
        nixfmt
        tree-sitter
        # tree-sitter-grammars.tree-sitter-norg
      ];
    };
  };
}
