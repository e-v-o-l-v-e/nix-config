{ config, ... }: {
  programs.zellij = {
    enableFishIntegration = true;
    attachExistingSession = true;
    exitShellOnExit = false;

    settings = {
      theme = if config.gui.theme == "light"
        then "gruvbox-light"
        else "gruvbox-dark";

      themes = {
        # RGB version (light theme)
        gruvbox-light = {
          fg = [ 60 56 54 ];
          bg = [ 251 82 75 ];
          black = [ 40 40 40 ];
          red = [ 205 75 69 ];
          green = [ 152 151 26 ];
          yellow = [ 215 153 33 ];
          blue = [ 69 133 136 ];
          magenta = [ 177 98 134 ];
          cyan = [ 104 157 106 ];
          white = [ 213 196 161 ];
          orange = [ 214 93 14 ];
        };

        # HEX version (dark theme)
        gruvbox-dark = {
          fg = "#D5C4A1";
          bg = "#282828";
          black = "#3C3836";
          red = "#CC241D";
          green = "#98971A";
          yellow = "#D79921";
          blue = "#3C8588";
          magenta = "#B16286";
          cyan = "#689D6A";
          white = "#FBF1C7";
          orange = "#D65D0E";
        };
      };
    };
  };
}
