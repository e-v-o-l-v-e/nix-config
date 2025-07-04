{...}: {
  programs.waybar = {

    style = ''
      .modules-right {
        padding: 0 5;
      }

      #clock {
        color: @base0C;
      }

      #battery {
        color: @base0C;
        padding: 0 10;
      }
    '';
  };

  stylix.targets.waybar.addCss = false;
}
