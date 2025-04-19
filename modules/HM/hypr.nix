{
  pkgs,
  lib,
  hostname,
  ...
}:
lib.mkIf (hostname == "waylander") {
  home.packages = with pkgs; [
    ags
    brightnessctl
    cava
    cpufrequtils
    gnome-system-monitor
    grim
    gtk-engine-murrine
    hypridle
    hyprland
    hyprlock
    hyprpicker
    hyprshade
    inxi
    nwg-displays
    nwg-look
    polkit_gnome
    rofi-wayland
    slurp
    swappy
    swaynotificationcenter
    swww
    wallust
    waybar
    wlogout
  ];

  programs = {
    hyprland = {
      enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };

    waybar = {
      enable = true;
    };

    hyprlock = {
      enable = true;
    };
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
}
