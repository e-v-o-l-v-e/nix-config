{ config, lib, ... }:
let
  cfg = config.laptop;
in
{
  config = {
    programs.light = {
      inherit (cfg) enable;
      brightnessKeys = {
        step = 5;
        enable = true;
      };
    };

    services = lib.mkForce {
      upower = {
        inherit (cfg) enable;
      };
      tlp = {
        inherit (cfg) enable;
      };
    };
  };
}
