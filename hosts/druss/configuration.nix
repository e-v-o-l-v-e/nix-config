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
  config = lib.mkMerge [
    {
      #=#=#=# HOME #=#=#=#
      personal.enable = true;

      sops-nix.enable = true;

      keyboard = {
        layout = "gb";
        variant = "extd";
      };

      # Theming #
      gui.enable = true;
      gui.theme = "dark";

      gui.font.size = 13;

      gui.quickshell.enable = false;
      gui.quickshell.caelestia = false;
      programs.waybar.enable = false;

      gui.stylix.enable = true;
      gui.stylix.colorSchemeDark = "tokyo-night-dark";
      gui.stylix.colorSchemeLight = "one-light";

      # if you want only one theme you can just uncomment this line
      # gui.stylix.colorScheme = "gruvbox-dark-medium";

      gaming.enable = true;
      gaming.full = true;
    }
    ( if HM then {
      #=#=#=# HOME #=#=#=#
      # Apps #
      programs.nvf.enable = true;
      programs.nvf.maxConfig = true;

      programs.zellij.enable = true;

      programs.zen-browser.enable = true;

      wayland.windowManager.hyprland.enable = false; # manage hyprland settings with home-manager

      # home-manager version at the time of first install, do not change
      home.stateVersion = "25.05";
    }
    else
    {
      #=#=#=# SYSTEM #=#=#=#
      laptop.enable = false;

      # nixos version at the time of first install, do not change
      system.stateVersion = "25.05";

      # Desktop #
      login-manager = "sddm";

      programs.hyprland.enable = false;

      services.desktopManager.plasma6.enable = true;

      # Apps #
      services.kanata.enable = false; # remapping tool, this enable my personal config following a home-row scheme

      # Network #
      services.tailscale.enable = true;
      server.vpn.enable = false;
      networking.interfaces.eth0.wakeOnLan.enable = true;
      hardware.bluetooth.enable = true;
    })
  ];
}
