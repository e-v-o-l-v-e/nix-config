{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.gui.stylix;
in
{
  # allow and enable stylix customization
  stylix = {
    inherit (cfg) enable;
    # set the chosen colorScheme
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${cfg.colorScheme}.yaml";
  };

  # environment.systemPackages = lib.optional cfg.enable pkgs.base16-schemes;
  options = {
    gui.stylix = {
      enable = lib.mkEnableOption "Enable theming with stylix";
      colorScheme = lib.mkOption {
        type = lib.types.str;
        default = "one-light";
        description = "Stylix baseScheme name";
      };
    };
  };
}
