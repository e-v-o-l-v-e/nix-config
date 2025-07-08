{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.gui.stylix;

  colorScheme = if cfg.colorScheme != null
      then cfg.colorScheme
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

    specialisation = lib.mkIf cfg.enableSpecialisation {
      dark.configuration = {
        gui.theme = "dark";
        stylix.base16Scheme = lib.mkForce "${pkgs.base16-schemes}/share/themes/${cfg.colorSchemeDark}.yaml";
      };
      
      light.configuration = {
        gui.theme = "light";
        stylix.base16Scheme = lib.mkForce "${pkgs.base16-schemes}/share/themes/${cfg.colorSchemeLight}.yaml";
      };
    };
  };
}
