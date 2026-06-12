{ inputs, ... }:
{
  flake.modules.homeManager = {
    cli-core =
      { pkgs, ... }:
      {
        imports = with inputs.self.modules.homeManager; [
          fish
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
          # cli-core

          starship
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
          file
          ffmpeg
          fzf
          imagemagick
          jq
          libnotify
          linux-manual
          man-pages
          man-pages-posix
          mediainfo
          openssl
          parted
          pciutils
          playerctl
          poppler # yazi pdf preview
          pulseaudio
          resvg # yazi svg preview
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
          # cli-core
          # cli-utils

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
          khal
          lowfi
          presenterm
          python3
          vdirsyncer
          sops
        ];
      };
  };
}
