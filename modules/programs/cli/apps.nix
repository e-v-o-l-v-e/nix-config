{ inputs, ... }:
{
  flake.modules.homeManager = {
    cli-core =
      { pkgs, ... }:
      {
        imports = [
          inputs.self.modules.homeManager.fish
          inputs.self.modules.homeManager.lsd
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
        imports = [
          inputs.self.modules.homeManager.cli-core

          inputs.self.modules.homeManager.starship
          inputs.self.modules.homeManager.fish
          inputs.self.modules.homeManager.pay-respects
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

          zoxide
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
