{ lib, ...}:
{
  gui = { 
    # global
    enable = lib.mkEnableOption "enable graphics, de etc";

    # de / compositor
    hyprland.enable = lib.mkEnableOption "Use hyprland compositor";
    plasma.enable = lib.mkEnableOption "Use plasma6 de";

    # color
    stylix = {
      enable = lib.mkEnableOption "Use stylix for theming";
      # default to real cool color
      theme = lib.mkOverride 1501 "gruvbox-dark-medium";
    };

    quickshell.enable = lib.mkEnableOption "Enable QuickShell with Caelestia config";
  };

  gaming = {
    enable = lib.mkEnableOption "Enable gaming capabilities (steam)";
    full = lib.mkEnableOption "Full gaming capabilities (heroic, etc)";
  };

  soft = {
    zen.enable = lib.mkEnableOption "Enable Zen Browser";
    nvf.enable = lib.mkEnableOption "Use notashelf's nvf, an amazing neovim wrapper";
  };
}
