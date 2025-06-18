{ config, lib, ... }:
  # this is where the per host configuration happens
  # all options and their default values are set in ./options.nix

  # the username is set globally as the username option's default
  # you can override it per host or change it in ./options.nix to use the same on every machine, current is "evolve"
let
  colorScheme = {
    # get your preferred theme here : https://tinted-theming.github.io/tinted-gallery/
    dark = "gruvbox-dark-medium";
    light = "one-light";
    light1 = "atelier-dune-light";
    light2 = "gruvbox-light-hard";
  };
in {
  config = {
    system-version = "24.11";
    laptop = true;
    gaming.enable = true;
    gui = {
      enable = true;
      theme = "light";
      hyprland.enable = true;
      stylix = {
        enable = true;
        colorScheme = colorScheme.light;
      };
      quickshell = {
        enable = true;
        caelestia.enable = true;
      };
    };
  };
}
