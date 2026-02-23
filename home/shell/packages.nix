{
pkgs,
config,
...
}:
{
  # common cli packages for all hosts
  home.packages = with pkgs; [

    # main
    bat
    curl
    fd
    git
    lsd
    ripgrep
    vim
    yazi
    zellij

    # neovim
    neovim
    fish-lsp
    # lua
    lua5_1
    luarocks
    lua-language-server
    tree-sitter
    # tree-sitter-grammars.tree-sitter-norg

    # nix
    nh
    nixd
    nixfmt
    alejandra
    nil
    sops

    # utilities
    calc
    ffmpeg
    fzf
    gitui
    gnutar
    imagemagick
    # linux-manual 
    man-pages
    man-pages-posix
    openssl
    ripgrep-all
    tree
    wget

    # system
    btop
    duf
    dust
    pciutils

    # data
    jq
    trashy
    unzip
    zip
  ]
  ++ lib.optionals config.personal.enable (with pkgs; [
    cava
    discordo
    fastfetch
    jellyfin-tui
    libnotify
    lowfi
    neo-cowsay
    playerctl
    presenterm
    xdg-utils
  ]);
}
