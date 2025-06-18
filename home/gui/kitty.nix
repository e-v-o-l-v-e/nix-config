{ config, ... }:
{
  programs.kitty = {
    inherit (config.gui.enable) enable;
    enableGitIntegration = true;
    settings = {
      cursor_trail = 10;
      window_padding_width = "2 5";
    };
  };
}
