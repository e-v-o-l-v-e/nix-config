_:
let
  layout = "gb";
  variant = "extd";
in
{
  flake.modules.nixos.keyboard = {
    services.xserver = {
      enable = true;
      xkb = {
        inherit layout variant;
      };
      autoRepeatInterval = 250;
    };

    console.keyMap = if (layout == "gb") then "uk" else layout;
  };
}
