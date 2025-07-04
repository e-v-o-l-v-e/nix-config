{ config, lib, ... }:
# this is where the per host configuration happens
# all options and their default values are set in ./options.nix

# the username is set globally as the username option's default
# you can override it per host or change it in ./options.nix to use the same on every machine, current is "evolve"
{
  config = {

    #=#=#=# HOME #=#=#=#
    personal.enable = true;

    home.keyboard = {
      layout = "gb";
      variant = "extd";
    };

    # Apps #
    programs.nvf.enable = true;
    programs.nvf.maxConfig = true;

    programs.zen.enable = true;

    gui.packages.enable = true;

    # Theming #
    gui.theme = "light";

    gui.quickshell.enable = true;
    gui.quickshell.caelestia = true;

    gui.stylix.enable = true;
    gui.stylix.colorScheme = "one-light";

    # home-manager version at the time of first install, do not change
    home.stateVersion = "24.11";

    #=#=#=# SYSTEM #=#=#=#

    laptop.enable = true;

    # nixos version at the time of first install, do not change
    system.stateVersion = "24.11";

    # Apps #
    login-manager = "greetd";
    programs.hyprland.enable = true;
    services.dispayManager.plasma6.enable = false;

    services.kanata.enable = true; # remapping tool, this enable my personal config following a home-row scheme

    # Network #
    services.tailscale.enable = true;
    server.airvpn.enable = false;
    interfaces.eth0.wakeOnLan.enable = false;
  };
}
