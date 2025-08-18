{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeScriptBin "theme-plasma-switch" ''
      #!/usr/bin/env fish

      type -q plasma-apply-colorscheme

      if test $status -ne 0
        exit
      end

      if test $THEME = "light"
        plasma-apply-colorscheme $THEME_PLASMA_LIGHT
      else
        plasma-apply-colorscheme $THEME_PLASMA_DARK
      end
      echo ""
    '')

    (pkgs.writeScriptBin "theme-plasma-init" ''
      #!/usr/bin/env fish

      set -U THEME_PLASMA_LIGHT "BreezeLight"
      set -U THEME_PLASMA_DARK "BreezeDark"
    '')

  ];
}
