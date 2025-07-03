{ lib, username, ... }:
let
  listNvfTheme = lib.types.enum [ 
    "base16" "catppuccin" "dracula" "github" "gruvbox"
    "mini-base16" "nord" "onedark" "oxocarbon" "rose-pine"
    "solarized" "solarized-osaka" "tokyonight"
  ];

  listNvfStyle = lib.types.enum [
    "dark" "darker" "cool" "deep"
    "warm" "warmer" "latte" 
    # i may have forgotten something,
    # know that latte is only for catppuccin
  ];
in
{
  options = {
    system-version = lib.mkOption {
      type = lib.types.str;
      default = "25.05";
      description = "NixOS first installation's system version";
    };


    personal.enable = lib.mkEnableOption "Whether this is a personal device, enable vesktop, jellyfin media player etc";
    laptop.enable = lib.mkEnableOption "Enable laptop related modules, battery management, brightness keys etc";

    networking = {
      wol.enable = lib.mkEnableOption "Enable wake on lan on eth0";
      tailscale.enable = lib.mkEnableOption "Enable tailscale";
    };

    gui = {
      enable = lib.mkEnableOption "Enable GUI (DE, compositor, etc)";

      hyprland.enable = lib.mkEnableOption "Use Hyprland";
      plasma.enable = lib.mkEnableOption "Use Plasma";

      theme = lib.mkOption {
        type = lib.types.enum [
          "dark"
          "light"
        ];
        default = "dark";
      };

      stylix = {
        enable = lib.mkEnableOption "Enable Stylix theming";
        colorScheme = lib.mkOption {
          type = lib.types.str;
          default = "gruvbox-dark-medium";
          description = "Stylix theme";
        };
      };

      quickshell = {
        enable = lib.mkEnableOption "Enable QuickShell";
        caelestia.enable = lib.mkEnableOption "Use Caelestia config for QuickShell";
      };
    };

    gaming = {
      enable = lib.mkEnableOption "Enable basic gaming support";
      full = lib.mkEnableOption "Enable full gaming stack (e.g. Heroic)";
    };


      timeZone = lib.mkOption {
        type = lib.types.str;
        default = "Europe/Paris";
      };

      gpu = lib.mkOption {
        type = lib.types.enum [
          "amd"
          "nvidia"
          "intel"
        ];
        default = "amd";
        description = "gpu type, to enable relevant drivers, currently only amd works";
      };
    };

    soft = {
      nvf = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Enable notashelf’s Neovim config (nvf)";
        };
        max = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Heavier config";
        };
        theme = {
          light = {
            name = lib.mkOption {
              default = "catppuccin";
              description = "nvf's light theme";
              type = listNvfTheme;
            };
            style = lib.mkOption {
              default = "latte";
              description = "nvf's light theme style";
              type = listNvfStyle;
            };
          };
          dark = {
            name = lib.mkOption {
              default = "gruvbox";
              description = "nvf's dark theme";
              type = listNvfTheme;
            };
            style = lib.mkOption {
              default = "dark";
              description = "nvf's light theme style\nNote that not all theme support all style";
              type = listNvfStyle;
            };
          };
        };
      };
    };
  };
}
