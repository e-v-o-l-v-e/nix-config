{
  config,
  pkgs,
  ...
}:
let
  cfg = config.gui.stylix;

  colorScheme = 
    if cfg.themeOverride != null
      then cfg.themeOverride
    else if config.gui.theme == "light"
      then cfg.colorSchemeLight
    else 
      cfg.colorSchemeDark;
in
{
  # enable system's stylix customization
  config.stylix = {
    inherit (cfg) enable;
    # set the chosen colorScheme
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${colorScheme}.yaml";
  };
}
