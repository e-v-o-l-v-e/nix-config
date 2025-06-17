{
  hostConfig,
  pkgs,
  lib,
  ...
}:
let
  cfg = hostConfig.gaming;
in
{
  programs = {
    steam = {
      inherit (cfg) enable;
      gamescopeSession.enable = cfg.full;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
    gamemode.enable = cfg.full;

    nix-ld = {
      enable = cfg.full;
      libraries = with pkgs; [
        freetype
        wine
        wine64
        wineWowPackages.full
        wineWow64Packages.full
        protonup
        amdvlk
        mesa
        vulkan-tools
        vulkan-loader
        # Add any missing dynamic libraries for unpackaged
        # programs here, NOT in environment.systemPackages
      ];
    };
  };

  environment.systemPackages = lib.optionals cfg.full [
    pkgs.mangohud
    pkgs.mangohud
  ];
}
