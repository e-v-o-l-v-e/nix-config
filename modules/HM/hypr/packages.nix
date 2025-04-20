{pkgs, ...}: {
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
}
