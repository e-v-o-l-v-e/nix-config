{ lib, ... }:
with lib;
{
  options = {
    personal.enable = mkEnableOption "Whether this is a personal device, enable vesktop, libreOffice etc";

    homeManagerOnly = mkEnableOption "For standalone home-manager";

    sops-nix.enable = mkEnableOption "Enable secrets management with sops-nix";

    flakePath = mkOption {
      type = types.str;
      default = "nix-config";
      description = "path to the flake directory from /home/{username}";
    };

    keyboard = {
      layout = mkOption {
        type = types.str;
        default = "gb";
        description = "Keyboard layout";
      };
      variant = mkOption {
        type = types.str;
        default = null;
        example = "extd";
        description = "Keyboard layout variant";
      };
    };

    gui = {
      enable = mkEnableOption "Enable gui and allow specifics packages";

      theme = mkOption {
        type = types.enum [
          "dark"
          "light"
        ];
        default = "dark";
      };
      
      font = {
        size = mkOption {
          type = types.int;
          default = 13;
          example = 15;
          description = "Terminal font size";
        };
      };

      hyprland.enable = mkEnableOption "Enable hyprland and related packages for my config";

      stylix = {
        enable = mkEnableOption "Enable theming with stylix";

        colorScheme = mkOption {
          type = types.nullOr types.str;
          default = null;
          # default = "tokyo-night-dark";
          example = "gruvbox-dark-medium";
          description = "Stylix baseScheme name to override dark and light";
        };

        colorSchemeLight = mkOption {
          type = types.str;
          default = "one-light";
          description = "Stylix light baseScheme";
        };

        colorSchemeDark = mkOption {
          type = types.str;
          default = "gruvbox-dark-medium";
          description = "Stylix dark baseScheme";
        };

        enableSpecialisation = mkEnableOption "Build config for dark and white theme, SLOW";
      };

      quickshell = {
        enable = mkEnableOption "Enable QuickShell";
        caelestia = mkEnableOption "Use Caelestia config for QuickShell";
      };
    };

    gaming = {
      enable = mkEnableOption "Enable basic gaming support";
      full = mkEnableOption "Enable full gaming stack (e.g. Heroic, gamescope etc)";
    };
  };
  #
  # config = {
  #   specialisation.dark.configuration = { config.gui.theme = "dark"; };
  #   specialisation.light.configuration = { config.gui.theme = "light"; };
  # };
}
