{ lib, ... }:
{
  options = {
    personal.enable = lib.mkEnableOption "Whether this is a personal device, enable vesktop, libreOffice etc";

    homeManagerOnly = lib.mkEnableOption "For standalone home-manager";

    sops-nix.enable = lib.mkEnableOption "Enable secrets management with sops-nix";

    flakePath = lib.mkOption {
      type = lib.types.str;
      default = "nix-config";
      description = "path to the flake directory from /home/{username}";
    };

    keyboard = {
      layout = lib.mkOption {
        type = lib.types.str;
        default = "gb";
        description = "Keyboard layout";
      };
      variant = lib.mkOption {
        type = lib.types.str;
        default = null;
        example = "extd";
        description = "Keyboard layout variant";
      };
    };

    gui = {
      enable = lib.mkEnableOption "Enable gui and allow specifics packages";

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

    gaming = {
      enable = lib.mkEnableOption "Enable basic gaming support";
      full = lib.mkEnableOption "Enable full gaming stack (e.g. Heroic, gamescope etc)";
    };
  };
}
