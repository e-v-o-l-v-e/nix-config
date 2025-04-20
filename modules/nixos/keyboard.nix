{...}: {
  services.xserver = {
    enable = true;
    xkb = {
      layout = "gb";
      variant = "extd";
    };
  };
}
