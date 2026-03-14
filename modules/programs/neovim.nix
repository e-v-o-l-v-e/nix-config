{ inputs, ... }:
{
  flake.modules.homeManager.neovim =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        neovim

        # core
        fd
        lua-language-server
        lua5_1
        luarocks
        ripgrep
        tree-sitter

        # dependencies (tree-sitter parser)
        gcc
        gnumake

        # nix
        alejandra
        nil
        nixd
        nixfmt

        # else
        fish-lsp
      ];

      programs.fish.functions = {
        "nvim" = {
          body = ''
            command nvim $argv -c "colorscheme $nvim_theme"
          '';
        };
        "nvimc" = {
          body = ''
            command nvim $argv
          '';
        };
      };
    };
}
