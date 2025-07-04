{ config, lib, ... }:
# this is where the per host configuration happens
# all options and their default values are set in ./options.nix

# the username is set globally as the username option's default
# you can override it per host or change it in ./options.nix to use the same on every machine, current is "evolve"
{
  config = {

    #=#=#=# HOME #=#=#=#
    personal.enable = true;

    keyboard = {
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

    gui.quickshell.enable = false;
    gui.quickshell.caelestia = false;

    gui.stylix.enable = true;
    gui.stylix.colorScheme = "one-light";


    #=#=#=# SYSTEM #=#=#=#

    laptop.enable = false;

    # nixos version at the time of first install, do not change
    system.stateVersion = "25.05";

    # Apps #
    login-manager = "sddm";
    programs.hyprland.enable = false;
    services.dispayManager.plasma6.enable = true;

    services.kanata.enable = false; # remapping tool, this enable my personal config following a home-row scheme

    # Network #
    services.tailscale.enable = true;
    server.airvpn.enable = false;
    networking.interfaces.eth0.wakeOnLan.enable = true;
  };
}
