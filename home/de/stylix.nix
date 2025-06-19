{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.gui.stylix;
in {
  stylix = {
    inherit (cfg) enable;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${cfg.colorScheme}.yaml";

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
  home.packages = lib.optional cfg.enable pkgs.base16-schemes;
}
