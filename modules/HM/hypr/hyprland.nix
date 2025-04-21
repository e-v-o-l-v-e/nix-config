{hostname, ...}: {
  wayland.windowManager.hyprland = {
    enable = hostname == "waylander";
  };
}
