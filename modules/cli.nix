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

    cli-personal =
      { pkgs, ... }:
      {
        imports = [
          inputs.self.modules.homeManager.cli-core
          inputs.self.modules.homeManager.cli-utils

          inputs.self.modules.homeManager.zoxide
          inputs.self.modules.homeManager.nix-index
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

    cli-nvim =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          alejandra
          fish-lsp
          lua-language-server
          lua5_1
          luarocks
          neovim
          nil
          nixd
          nixfmt
          tree-sitter
        ];
      };
  };
}
