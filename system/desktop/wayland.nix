{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.gui;
in {
  programs =  {
    hyprland = lib.mkIf config.programs.hyprland.enable {
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };
    dconf = {
      enable = true;
    };
    niri.enable = true;
  };

  environment.systemPackages = lib.optionals config.programs.niri.enable [
    pkgs.alacritty pkgs.fuzzel pkgs.swaylock pkgs.mako pkgs.swayidle pkgs.xwayland-satellite
  ];

  security.polkit.enable = config.programs.niri.enable;
  services.gnome.gnome-keyring.enable = config.programs.niri.enable; # secret service
  security.pam.services.swaylock = {};

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
