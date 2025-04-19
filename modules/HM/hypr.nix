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
    waybar
  ];

  programs.hyprland = {
    enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland; # xdph none git
    xwayland.enable = true;
  };

  programs.waybar = {
    enable = true;
  };

  programs.hyprlock = {
    enable = true;
  };
}
