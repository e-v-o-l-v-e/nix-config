{
  config,
  pkgs,
  lib,
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
  config = {
    stylix = {
      inherit (cfg) enable;

      base16Scheme = "${pkgs.base16-schemes}/share/themes/${colorScheme}.yaml";

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.daddy-time-mono;
          name = "DaddyTimeMono Nerd Font";
        };
        sansSerif = {
          package = pkgs.nerd-fonts.daddy-time-mono;
          name = "DaddyTimeMono Nerd Font";
        };
        serif = {
          package = pkgs.nerd-fonts.daddy-time-mono;
          name = "DaddyTimeMono Nerd Font";
        };

        sizes.terminal = 13;
      };
    };
    home.packages = lib.optional config.stylix.enable pkgs.base16-schemes;
  };
}
