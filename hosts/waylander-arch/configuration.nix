{
  lib,
  HM,
  config,
  ...
}:
# this is where the per host configuration happens
# all options and their default values are set in ./options.nix

# the username is set globally as the username option's default
# you can override it per host or change it in ./options.nix to use the same on every machine, current is "evolve"
{
  config = {
    flakePath = ".dotfiles/nix-config";

    #=#=#=# HOME #=#=#=#
    personal.enable = true;

    sops-nix.enable = true;

    keyboard = {
      layout = "gb";
      variant = "extd";
    };

    # gui / theming #
    gui.enable = true;
    gui.theme = "light";

    # specialisation."light".configuration = {
    #   gui.theme = "light";
    #   environment.etc."specialisation".text = "light";
    # };

    programs.kitty.enable = true;
    programs.kitty.nixConfig.enable = false;

    gui.hyprland.enable = true;

    programs.waybar.enable = true;

    gaming.enable = true;
    gaming.full = false;

    #=#=#=# HOME #=#=#=#
    # Apps #
    programs.nvf.enable = true;
    programs.nvf.maxConfig = true;

    programs.zellij.enable = true;

    programs.zen-browser.enable = true;

    programs.starship.settings = lib.mkForce { };

    wayland.windowManager.hyprland.enable = false; # manage hyprland settings with home-manager

    # home-manager version at the time of first install, do not change
    home.stateVersion = "25.05";
  };
}
