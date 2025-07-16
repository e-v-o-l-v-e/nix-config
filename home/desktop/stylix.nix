{ config, pkgs, ... }:
let
  cfg = config.gui.stylix;

  colorScheme = 
    if cfg.override
      then cfg.overrideColorScheme
    else if config.gui.theme == "dark"
      then cfg.colorSchemeDark
    else 
      cfg.colorSchemeLight;
in
{
  config = {
    stylix = {
      # inherit (cfg) enable;
      enable = false;

      base16Scheme = "${pkgs.base16-schemes}/share/themes/${colorScheme}.yaml";

      # fonts = {
      #   monospace = {
      #     package = pkgs.nerd-fonts.daddy-time-mono;
      #     name = "DaddyTimeMono Nerd Font";
      #   };
        # sansSerif = {
        #   package = pkgs.nerd-fonts.daddy-time-mono;
        #   name = "DaddyTimeMono Nerd Font";
        # };
        # serif = {
        #   package = pkgs.nerd-fonts.daddy-time-mono;
        #   name = "DaddyTimeMono Nerd Font";
        # };

      #   sizes.terminal = config.gui.font.size;
      # };

      targets.zellij.enable = false;
    };

    # specialisation = {
    #   dark.configuration = {
    #     gui.theme = "dark";
    #     base16Scheme = "${pkgs.base16-schemes}/share/themes/${colorScheme}.yaml";
    #   };
    #   
    #   light.configuration = {
    #     gui.theme = "light";
    #     base16Scheme = "${pkgs.base16-schemes}/share/themes/${colorScheme}.yaml";
    #   };
    # };
  };
}
