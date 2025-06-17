{
  hostConfig,
  lib,
  pkgs,
  ...
}:
let
  cfg = hostConfig.gui;
in
{
  programs = lib.mkIf cfg.hyprland.enable {
    hyprland = {
      enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };
    programs.dconf = {
      enable = true;
    };
  };

  services = lib.mkIf cfg.plasma.enable {
    xserver.enable = true;
    desktopManager.plasma6.enable = true;
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
}
