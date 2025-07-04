{ lib, ... }:
{
  options = {
    personal.enable = lib.mkEnableOption "Whether this is a personal device, enable vesktop, libreOffice etc";

    laptop.enable = lib.mkEnableOption "Enable laptop related modules, battery management, brightness keys etc";

    homeManagerOnly = lib.mkEnableOption "For standalone home-manager";

    flakePath = lib.mkOption {
      type = lib.types.str;
      default = "nix-config";
      description = "path to the flake directory from /home/{username}";
    };

    keyboard = {
      
    };

    gui = {
      packages.enable = lib.mkEnableOption "Enable packages that needs a gui";

      theme = lib.mkOption {
        type = lib.types.enum [
          "dark"
          "light"
        ];
        default = "light";
      };

      stylix = {
        enable = lib.mkEnableOption "Enable theming with stylix";
        colorScheme = lib.mkOption {
          type = lib.types.str;
          default = "one-light";
          example = "gruvbox-dark-medium";
          description = "Stylix baseScheme name";
        };
      };

      quickshell = {
        enable = lib.mkEnableOption "Enable QuickShell";
        caelestia = lib.mkEnableOption "Use Caelestia config for QuickShell";
      };
    };
  };
}
