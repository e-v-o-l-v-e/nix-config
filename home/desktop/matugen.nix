{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.gui.matugen;
in {
  config = {
    home.packages = lib.mkIf cfg.enable (with pkgs; [
      matugen
      pywal16
    ]);
  };

  options = {
    gui.matugen.enable = lib.mkEnableOption "Enable matugen packages";
  };
}
