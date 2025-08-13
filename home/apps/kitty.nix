{
  config,
  lib,
  pkgs,
  ...
}: let
  theme = {
    initialDark = "Alabaster_Dark";
    # light = "Catppuccin-Latte";
    initialLight = "Doom_One_Light"; # least unreadable light theme
  };
in {
  programs.kitty = {
    inherit (config.gui) enable;

    enableGitIntegration = true;

    settings = {
      cursor_trail = 10;
      window_padding_width = "2 5";
      allow_remote_control = "yes";
      listen_on = "unix:/tmp/mykitty";
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

    # themeFile = "SpaceGray_Eighties";
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
        mv -v theme.conf.previous theme.conf
        kitten @ load-config
        exit
      end

      if test $argv[1] = "list"
        for t in ./themes/*
          basename $t | cut -d "." -f 1
        end
        exit
      end

      mv -v theme.conf theme.conf.previous

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
        
      # reload
      kill -SIGUSR1 $(pgrep kitty)

      echo ""
    '')

    (pkgs.writeScriptBin "theme-kitty-init" ''
      #!/usr/bin/env fish

      set -U THEME_KITTY_LIGHT ${theme.initialLight}
      set -U THEME_KITTY_DARK ${theme.initialDark}
    '')
  ];
}
