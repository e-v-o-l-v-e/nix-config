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
  environment.systemPackages = lib.optional cfg.enable pkgs.base16-schemes;

  # enable boot loading styling
  boot.plymouth.enable = cfg.enable;
}
