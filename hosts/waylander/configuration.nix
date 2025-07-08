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

      gui.stylix.enable = true;
      gui.stylix.colorSchemeDark = "tokyo-night-dark";
      gui.stylix.colorSchemeLight = "one-light";
      # gui.stylix.colorScheme = lib.mkForce "gruvbox-dark-medium";

      # gui.stylix.colorScheme = 
      #   (if config.gui.theme == "light" 
      #   then config.gui.stylix.colorSchemeLight
      #   else config.gui.stylix.colorSchemeDark);

      programs.waybar.enable = true;

      gaming.enable = true;
      gaming.full = false;
    }
    ( if HM then {
      #=#=#=# HOME #=#=#=#
      # Apps #
      gui.quickshell.enable = true;
      gui.quickshell.caelestia = true;

      programs.nvf.enable = true;
      programs.nvf.maxConfig = true;
      # programs.nvf.settings.vim.theme = lib.mkForce {
      #   enable = true;
      #   # name = "tokyonight";
      #   # style = "night";
      # };

      programs.zen-browser.enable = true;

      wayland.windowManager.hyprland.enable = false; # manage hyprland settings with home-manager

      # home-manager version at the time of first install, do not change
      home.stateVersion = "24.11";
    }
    else
    {
      #=#=#=# SYSTEM #=#=#=#
      laptop.enable = true;

      # nixos version at the time of first install, do not change
      system.stateVersion = "24.11";

      # Desktop #
      login-manager = "greetd";

      programs.hyprland.enable = true;

      services.desktopManager.plasma6.enable = false;

      # Apps #
      services.kanata.enable = true;

      # Network #
      services.tailscale.enable = true;
      server.vpn.enable = false;
    })
  ];
}
