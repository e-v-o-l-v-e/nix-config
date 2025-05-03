{
  pkgs,
  gaming,
  username,
  ...
}: let
  gamingPkgs = {
    full = with pkgs; [
      heroic
      steam
      steam-run
      wine
      umu-launcher
      protonup
      amdvlk
      vkd3d
      vkd3d-proton
      dxvk_2
      directx-headers
    ];
    simple = with pkgs; [
      steam
    ];
  };
in {
  home.packages = gamingPkgs.${gaming} or [];
  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/evolve/steam/root/compatibilitytools.d/";
  };
}
