{ config, lib, ... }:
{
  programs.kitty = {
    inherit (config.gui) enable;

    font = lib.mkForce {
      size = 12;
      name = "FiraCode";
    };

    settings = {
      cursor_trail = 10;
      window_padding_width = "2 5";
    };

    enableGitIntegration = true;
  };
}
