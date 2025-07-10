{
  pkgs,
  self,
  config,
  ...
}:
{
  # common cli packages for all hosts
  home.packages = with pkgs; [
      bat
      btop
      curl
      duf
      dust
      fd
      fish
      fzf
      git
      gitui
      gnutar
      imagemagick
      jq
      lsd
      networkmanager
      nixd
      pciutils
      ripgrep
      ripgrep-all
      sops
      starship
      tmux
      trashy
      tree
      unzip
      vim
      wget
      zellij
      zip
      zoxide
    ]
    ++ lib.optionals (config.personal.enable) (with pkgs; [
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
