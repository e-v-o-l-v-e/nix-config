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

      # gui / theming #
      gui.enable = true;
      gui.theme = "light";

      # specialisation."light".configuration = {
      #   gui.theme = "light";
      #   environment.etc."specialisation".text = "light";
      # };

      gui.hyprland.enable = true;

      gui.stylix.enable = false;
      gui.stylix.colorSchemeDark = "tokyo-night-dark";
      gui.stylix.colorSchemeLight = "one-light";

      gui.stylix.override = true;
      gui.stylix.overrideColorScheme = 
        if config.gui.theme == "light"
        then config.gui.stylix.colorSchemeLight
        else config.gui.stylix.colorSchemeDark;

      programs.waybar.enable = true;

      gaming.enable = true;
      gaming.full = false;
    }
    ( if HM then {
      #=#=#=# HOME #=#=#=#
      # Apps #
      programs.nvf.enable = true;
      programs.nvf.maxConfig = true;
      # programs.nvf.settings.vim.theme = lib.mkForce {
      #   enable = true;
      #   # name = "tokyonight";
      #   # style = "night";
      # };

      programs.zellij.enable = true;

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

      programs.hyprland.enable = config.gui.hyprland.enable;

      services.desktopManager.plasma6.enable = false;

      # Apps #
      services.kanata.enable = true;

      # Network #
      hardware.bluetooth.enable = true;
      services.tailscale.enable = true;

      ## SERVER TESTING ##
      # server.enable = true;
      # server.domain = "imp-network.com";
      # services.jellyfin.enable = true;
      # services.caddy.enable = true;
    })
  ];
}
