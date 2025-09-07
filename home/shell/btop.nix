{ pkgs, lib, ... }: {
  programs.btop = {
    enable = true;

    settings = {
      color_theme = "matugen";
      theme_background = true;
    };
  };

  home.packages = [
    (pkgs.writeScriptBin "theme-btop-switch" ''
      #!/usr/bin/env fish

      set narg (count $argv)
      if test $narg -ne 1
        echo "need one argument [ dark light restore ]"
        exit
      end

      echo "# BTOP THEME SWITCHING"
      cd $HOME/.config/btop

      if test $argv[1] = "restore"
        echo restore previous theme :
        mv -v theme.conf.previous btop.conf
        exit
      end

      if test $argv[1] = "list"
        for t in ./themes/*
          basename $t | cut -d "." -f 1
        end
        exit
      end

      mv btop.conf theme.conf.previous

      if test $argv[1] = "light"
        ln -sv theme-light.conf btop.conf
      else if test $argv[1] = "dark"
        ln -sv theme-dark.conf btop.conf
      end

      echo ""
    '')

    (pkgs.writeScriptBin "theme-btop-init" ''
      #!/usr/bin/env fish

      set btopdir $HOME/.config/btop

      mkdir -p $btopdir

      echo 'color_theme = "gruvbox_light"' > $btopdir/theme-light.conf
      echo 'color_theme = "gruvbox_dark"' > $btopdir/theme-dark.conf
    '')
  ];
}
