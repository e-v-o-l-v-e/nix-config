{
  gaming,
  pkgs,
  lib,
  ...
}: let
  opti = gaming == "simple";
  battlestation = gaming == "full";
in {
  programs = {
    steam.enable = opti;
    steam.gamescopeSession.enable = battlestation;
    gamemode.enable = battlestation;

    nix-ld = {
      enable = battlestation;
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
  environment.systemPackages =
    lib.optionals battlestation
    [
      pkgs.mangohud
      pkgs.mangohud
    ];
}
