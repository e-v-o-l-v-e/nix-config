{ config, pkgs, lib, ... }:
let
  cfg = config.gaming;
in
{
  config.programs = {
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
}
