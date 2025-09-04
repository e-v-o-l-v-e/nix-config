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
  config = {
    # programs.kitty = lib.mkIf config.programs.kitty.nixConfig.enable {
    programs.kitty = {
      inherit (config.gui) enable;
      enableGitIntegration = true;

      settings = {
        cursor_trail = 10;
        window_padding_width = "2 5";
        allow_remote_control = "yes";
      };

      font = lib.mkForce {
        size = 12;
        name = "FiraCode";
      };

      # this allow to switch theme on the fly without rebuilding,
      # if you only want to use one theme you can remove it (and the rest of the file to)
      # and just use the themeFile option below

      extraConfig = ''
        include colors.conf
      '';

      # themeFile = "SpaceGray_Eighties";
    };

    xdg.configFile = lib.mkIf config.programs.kitty.nixConfig.enable {
      "kitty/themes".source = pkgs.kitty-themes + "/share/kitty-themes/themes";
    };

    # simple fish script to change the theme
    home.packages = [
      (pkgs.writeScriptBin "theme-kitty-switch" ''
        #!/usr/bin/env fish

        set -l narg (count $argv)
        if test $narg -ge 2
            echo "need zero or one argument [ dark light list restore <theme name> ]"
            exit 1
        end

        echo "# KITTY THEME SWITCHING"
        cd $HOME/.config/kitty

        # No arguments → toggle based on $THEME
        if test $narg -eq 0
            if test "$THEME" = "light"
                ln -sv themes/$THEME_KITTY_LIGHT.conf theme.conf
            else
                ln -sv themes/$THEME_KITTY_DARK.conf theme.conf
            end

        # One argument
        else if test $narg -eq 1
            if test "$argv[1]" = "restore"
                mv -v theme.conf.previous theme.conf
                kitten @ load-config
                exit 0
            end

            if test "$argv[1]" = "list"
                for t in themes/*.conf
                    basename $t .conf
                end
                exit 0
            end

            mv theme.conf theme.conf.previous

            if test "$argv[1]" = "light"
                ln -sv themes/$THEME_KITTY_LIGHT.conf theme.conf
            else if test "$argv[1]" = "dark"
                ln -sv themes/$THEME_KITTY_DARK.conf theme.conf
            else
                if test -e themes/$argv[1].conf
                    ln -sv themes/$argv[1].conf theme.conf
                else
                    echo "This theme doesn’t exist, restoring previous"
                    mv theme.conf.previous theme.conf
                end
            end
        end

        # Reload kitty
        kill -SIGUSR1 (pgrep kitty)

        echo ""
      '')

      (pkgs.writeScriptBin "theme-kitty-init" ''
        #!/usr/bin/env fish

        set -U THEME_KITTY_LIGHT ${theme.initialLight}
        set -U THEME_KITTY_DARK ${theme.initialDark}
      '')
    ];
  };

  options = {
    programs.kitty.nixConfig.enable = lib.mkEnableOption "Enable nixified kitty config";
  };
}
