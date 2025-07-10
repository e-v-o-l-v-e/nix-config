{ config, ... }:
{
  programs.kitty = {
    inherit (config.gui) enable;

    font = {
      inherit (config.gui.font) size;
      name = "DaddyTimeMono";
    };

    settings = {
      cursor_trail = 10;
      window_padding_width = "2 5";
    };

    enableGitIntegration = true;
  };
}
