{ config, ... }:
let
  cfg = config.laptop.enable;
in
{
  programs.light = {
    inherit (cfg) enable;
    brightnessKeys = {
      step = 5;
      enable = true;
    };
  };

  services = {
    upower = {
      inherit (cfg) enable;
    };
    tlp = {
      inherit (cfg) enable;
    };
  };
}
