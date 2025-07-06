{
  config,
  pkgs,
  ...
}:
let
  cfg = config.gui.stylix;
in
{
  # enable system's stylix customization
  config.stylix = {
    inherit (cfg) enable;
    # set the chosen colorScheme
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${cfg.colorScheme}.yaml";
  };
}
