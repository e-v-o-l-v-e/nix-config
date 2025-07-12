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
    ripgrep-all
    tmux
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
    libnotify
    lowfi
    pamixer
    presenterm
    xdg-utils
  ]);

  # some programs need to be enabled like this to allow stylix auto theming
  programs = {
    btop.enable = true;
    fd.enable = true;
    cava.enable = config.personal.enable;
  };
}
