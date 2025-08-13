{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    # CUSTOMS SCRIPTS
    (pkgs.writeScriptBin "theme-global-switch" ''
      #!/usr/bin/env fish

      set narg (count $argv)
      if test $narg -eq 1
        if test $argv[1] = "dark"
          set -U THEME "dark"
        else if test $argv[1] = "light"
          set -U THEME "light"
        else
          echo "you can chose between dark, light or no args"
          exit
        end

      # when no arg is specified: invert dark and light
      else if test $THEME = "dark"
        set -U THEME "light"
      else 
        set -U THEME "dark"
      end

      if type -q cowsay
        cowsay --aurora -f dragon "changing theme to $argv[1] " 
        echo ""
      end

      # kitty switch, defined in ../apps/kitty.nix
      theme-kitty-switch $THEME

      # gtk switch, defined in ./gtk.nix
      theme-gtk-switch

      # nvim switch, defined in ../nvf.nix
      theme-nvim-switch

      # plasma switch, defined in ./plasma.nix
      theme-plasma-switch

      # btop switch, defined in ../shell/btop.nix
      theme-btop-switch $THEME
    '')

    (pkgs.writeScriptBin "theme-global-init" ''
      #!/usr/bin/env fish

      # initial global theme, dark is the default
      # override in ../../hosts/${hostname}/configuration.nix
      set -U THEME ${config.gui.theme}

      # apps
      theme-kitty-init
      theme-nvim-init
      theme-btop-init

      # enable theme
      theme-global-switch
    '')
  ];
}
