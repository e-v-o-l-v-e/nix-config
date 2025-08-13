{ pkgs, ... }: {

  home.packages = with pkgs; [
    gtk4
    gtk3
    dconf

    (pkgs.writeScriptBin "theme-gtk-switch" ''
      #!/usr/bin/env fish

      if test $THEME = "light"
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
      else
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
      end
      echo ""
    '')
  ];
}
