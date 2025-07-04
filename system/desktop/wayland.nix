{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.gui;
in
{
  config = {
    # programs = lib.mkIf cfg.hyprland.enable {
    programs = lib.mkIf config.programs.hyprland.enable {
      hyprland = {
        portalPackage = pkgs.xdg-desktop-portal-hyprland;
        xwayland.enable = true;
      };
      dconf = {
        enable = true;
      };
    };
    home-manager.extraSpecialArgs.hyprlandEnabled = config.programs.hyprland.enable;

    services = lib.mkIf config.services.desktopManager.plasma6.enable {
      xserver.enable = true;
      # desktopManager.plasma6.enable = true;
    };

    # wayland config
    xdg.portal = lib.mkIf cfg.enable {
      enable = true;
      wlr.enable = false;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
      configPackages = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal
      ];
    };

    environment.sessionVariables = lib.mkIf cfg.enable {
      NIXOS_OZONE_WL = "1";
    };

    hardware.graphics = lib.mkIf cfg.enable {
      enable = true;
      enable32Bit = true;
    };
  };

  # options = {
  #   gui = {
  #     hyprland.enable = lib.mkEnableOption "Use Hyprland";
  #     plasma.enable = lib.mkEnableOption "Use Plasma";
  #   };
  # };
}
