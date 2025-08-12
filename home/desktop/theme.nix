{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [
    # GTK
    dconf
    dconf-editor
    glib

    # QT
    gsettings-qt

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

      # btop switch, defined in ../shell/btop.nix
      theme-btop-switch $THEME
    '')

    (pkgs.writeScriptBin "theme-initial-install" ''
      #!/usr/bin/env fish

      set -U THEME "dark"

      # btop
      set btopdir $HOME/.config/btop
      mkdir -p $btopdir
      echo 'color_theme = "gruvbox_light"' > $btopdir/theme-light.conf
      echo 'color_theme = "gruvbox_dark"' > $btopdir/theme-dark.conf

      theme-global-switch
    '')
  ];
}
