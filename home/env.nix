{ config, ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
    NH_FLAKE = "/home/evolve/nix-config";
    TERM = if (config.programs.kitty.enable) then "xterm-kitty" else "xterm-256color";
  };
}
