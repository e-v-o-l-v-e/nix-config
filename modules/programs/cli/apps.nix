{ inputs, ... }:
{
  flake.modules.homeManager = {
    cli-core =
      { pkgs, ... }:
      {
        imports = with inputs.self.modules.homeManager; [
          fish
          git
          lsd
        ];

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
          stow
          tree
          unzip
          vim
          wget
          zip
        ];
      };

    cli-utils =
      { pkgs, ... }:
      {
        imports = with inputs.self.modules.homeManager; [
          cli-core

          starship
          fish
          nh
          pay-respects
          zoxide
        ];

        home.packages = with pkgs; [
          bc
          bat-extras.batman
          calc
          duf
          ethtool
          fastfetch
          ffmpeg
          fzf
          imagemagick
          jq
          libnotify
          linux-manual
          man-pages
          man-pages-posix
          openssl
          parted
          pciutils
          playerctl
          tmux
          trashy
          xdg-utils
          yazi
        ];
      };

    cli-personal =
      { pkgs, ... }:
      {
        imports = with inputs.self.modules.homeManager; [
          cli-core
          cli-utils

          nix-index

          direnv
          gh
          git
          ssh
          zk
        ];

        home.packages = with pkgs; [
          cava
          discordo
          jellyfin-tui
          lowfi
          presenterm
          sops
        ];
      };
  };
}
