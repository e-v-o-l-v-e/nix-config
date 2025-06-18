{
  pkgs,
  self,
  hostConfig,
  system,
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
    ++ [ self.packages."${system}".nvf-max ]
    ++ lib.optionals (hostConfig.personal) (with pkgs; [
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
    cava.enable = hostConfig.personal.enable;
  };
}
