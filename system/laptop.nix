{ config, lib, ... }:
let
  cfg = config.laptop;
in
{
  config = {
    services = lib.mkForce {
      upower = {
        inherit (cfg) enable;
      };
      tlp = {
        inherit (cfg) enable;
      };
    };

    security.polkit.enable = true;
  };

  options = {
    laptop.enable = lib.mkEnableOption "Enable laptop related modules, battery management, brightness keys etc";
  };
}
