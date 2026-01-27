{
  pkgs,
  config,
  lib,
  ...
}:let
  cfg = config.gaming;
in {
  home.packages = lib.mkIf cfg.full [
      pkgs.heroic
      pkgs.steam-run
      pkgs.wine
      pkgs.umu-launcher
      pkgs.protonup-ng
      pkgs.vkd3d
      pkgs.vkd3d-proton
      pkgs.dxvk_2
      pkgs.directx-headers

      pkgs.ryubing
    ];

  # home.sessionVariables = {
  #   STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/evolve/steam/root/compatibilitytools.d/";
  # };
}
