{
  pkgs,
  lib,
  hostname,
  ...
}:
lib.mkIf (hostname == "waylander") {
  programs = {
    hyprland = {
      enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };

    # waybar = {
    #   enable = true;
    # };

    # hyprlock = {
    #   enable = true;
    # };
  };

  # Extra Portal Configuration
  xdg.portal = {
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

  # For Electron apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
