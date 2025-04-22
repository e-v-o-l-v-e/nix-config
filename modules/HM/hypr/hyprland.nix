{hostname, ...}: {
  wayland.windowManager.hyprland = {
    # enable = hostname == "waylander";
    enable = false;
  };
}
