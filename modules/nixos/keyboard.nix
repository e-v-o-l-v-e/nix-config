{...}: {
  console.keyMap = "uk";

  services.xserver = {
    enable = true;
    xkb = {
      layout = "gb";
      variant = "extd";
    };
  };
}
