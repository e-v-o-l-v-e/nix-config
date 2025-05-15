{ lib, config, ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
    TERM = lib.mkIf config.kitty.enable == false "xterm-256color";
  };
}
