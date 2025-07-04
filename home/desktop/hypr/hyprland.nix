{ config, lib, ... }:
{
  config = {
    wayland.windowManager.hyprland = {
      inherit (config.gui.hyprland.hm) enable;
    };
  };

  options = {
    hyprland.hm.enable = lib.mkEnableOption "Manage hyprland settings with home-manager";
  };
}
