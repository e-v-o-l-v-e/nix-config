{
  config,
  lib,
  pkgs,
  ...
}: let
  theme = {
    dark = "Alabaster_Dark";
    light = "AtomOneLight";
  };
in {
  programs.kitty = {
    inherit (config.gui) enable;

    enableGitIntegration = true;

    settings = {
      cursor_trail = 10;
      window_padding_width = "2 5";
    };

    font = lib.mkForce {
      size = 12;
      name = "FiraCode";
    };

    # this allow to switch theme on the fly without rebuilding,
    # if you only want to use one theme you can remove it (and the rest of the file to)
    # and just use the themeFile option below

    extraConfig = ''
      include theme.conf
    '';

    # themeFile = "SpaceGray_Eighties";;
  };

  xdg.configFile."kitty/themes".source = pkgs.kitty-themes + "/share/kitty-themes/themes";

  # simple fish script to change the theme
  home.packages = [
    (pkgs.writeScriptBin "theme-kitty-switch" ''
      #!/usr/bin/env fish

      set narg (count $argv)
      if test $narg -ne 1
        echo "need one argument [ dark light list restore <theme name> ]"
        exit
      end

      echo "# KITTY THEME SWITCHING"
      cd $HOME/.config/kitty

      if test $argv[1] = "restore"
        echo restore previous theme :
        mv -v theme.conf.previous theme.conf
        exit
      end

      if test $argv[1] = "list"
        for t in ./themes/*
          basename $t | cut -d "." -f 1
        end
        exit
      end

      echo backup current theme :
      mv -v theme.conf theme.conf.previous

      echo enable $argv theme
      if test $argv[1] = "light"
        ln -sv themes/${theme.light}.conf theme.conf
      else if test $argv[1] = "dark"
        ln -sv themes/${theme.dark}.conf theme.conf
      else
        if test -e themes/$argv[1].conf
          ln -vs themes/$argv[1].conf theme.conf
        else
          echo this theme doesnt exist, restoring
          mv -v theme.conf.previous theme.conf
        end
      end
    '')
  ];

  home.activation = {
    kittyTheme = lib.hm.dag.entryAfter ["writeBoundary"] ''
      target="$HOME/.config/kitty/theme.conf"
      link="./themes/Alabaster_Dark.conf"
      if [ ! -e "$target" ]; then
        mkdir -p "$(dirname "$target")"
        ln -s "$link" "$target"
      fi
    '';
  };
}
