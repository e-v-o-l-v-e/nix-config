{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeScriptBin "theme-plasma-switch" ''
      #!usr/bin/env fish

      if test (type -q plasma-apply-colorscheme) -ne 0
        exit
      end

      if test $THEME = "light"
        plasma-apply-colorscheme BreezeLight   
      else
        plasma-apply-colorscheme BreezeDark
      end
      echo ""
    '')
  ];
}
