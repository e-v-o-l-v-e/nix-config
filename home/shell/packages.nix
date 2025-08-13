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
    zellij

    # nix
    nh
    nixd
    sops

    # utilities
    fzf
    gitui
    gnutar
    imagemagick
    linux-manual 
    man-pages
    man-pages-posix
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
    fastfetch
    jellyfin-tui
    libnotify
    lowfi
    neo-cowsay
    pamixer
    presenterm
    xdg-utils
  ]);
}
