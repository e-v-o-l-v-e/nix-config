{ config, ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
    TERM = if (config.programs.kitty.enable) then "xterm-kitty" else "xterm-256color";
  };
}
