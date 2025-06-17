{
  hostConfig,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  cfg = hostConfig.gui.stylix;
in
{
  # this enable stylix customization
  imports = lib.optional cfg.enable inputs.stylix.nixosModules.stylix;

  stylix = {
    inherit (cfg) enable;
    # set the chosen colorScheme
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${cfg.theme}.yaml";

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
