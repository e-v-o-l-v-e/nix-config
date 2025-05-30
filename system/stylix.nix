{
  pkgs,
  personal,
  lib,
  colorScheme,
  config,
  ...
}:
{
  # this enable stylix customization
  stylix.enable = personal;
  environment.systemPackages = lib.optional personal pkgs.base16-schemes;
  stylix.base16Scheme =
    if (colorScheme != "") then
      # set the chosen colorScheme
      "${pkgs.base16-schemes}/share/themes/${colorScheme}.yaml"
    else
      # if no colorScheme is set default to a cool light colorScheme to avoid failure at build
      "${pkgs.base16-schemes}/share/themes/emil.yaml";

  stylix.fonts = {
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

  # enable boot loading styling
  boot.plymouth.enable = personal;
}
