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

    # from /home/{username}
    flakePath = lib.mkOption {
      type = lib.types.str;
      default = "nix-config";
      description = "path to the flake directory from /home/{username}";
    };

    personal.enable = lib.mkEnableOption "Whether this is a personal device";
    laptop.enable = lib.mkEnableOption "Enable laptop related modules, battery management, brightness keys etc";

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

    login-manager = lib.mkOption {
      type = lib.types.enum [
        "greetd"
        "sddm"
        null
      ];
      default = "greetd";
      description = "Which login manager to use";
    };

    hardware = {
      keyboard = {
        layout = lib.mkOption {
          type = lib.types.str;
          default = "gb";
          description = "Keyboard layout";
        };
        variant = lib.mkOption {
          type = lib.types.str;
          default = "extd";
          description = "Keyboard layout variant";
        };

        kanata = {
          enable = lib.mkEnableOption "Enable kanata for remapping, evolve's home-row config";
        };
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

    server = {
      enable = lib.mkEnableOption "Enable server modules";
      
      airvpn.enable = lib.mkEnableOption "Enable connection with airvpn through wireguard";

      services = {
        opencloud.enable = lib.mkEnableOption "Enable Opencloud";
        jellyfin.enable = lib.mkEnableOption "Enable Jellyfin";
        prowlarr.enable = lib.mkEnableOption "Enable Prowlarr";
        radarr.enable = lib.mkEnableOption "Enable Radarr";
        sonarr.enable = lib.mkEnableOption "Enable Sonarr";
        readarr.enable = lib.mkEnableOption "Enable Readarr";
        lidarr.enable = lib.mkEnableOption "Enable Lidarr";
      };

      configPath = lib.mkOption {
        type = lib.types.str;
        default = "/services-config";
        description = "path to the server's services config dir, from /home/{username}";
      };

      dataPath = lib.mkOption {
        type = lib.types.str;
        default = "/data";
        description = "path to the data dir";
      };

      mediaGroupName = lib.mkOption {
        type = lib.types.str;
        default = "media";
        description = "Nom du groupe auquel appartiendront les services media (arr stack, jellyfin etc)";
      };

      mediaGroupId = lib.mkOption {
        type = lib.types.int;
        default = 2000;
        description = "Id du groupe auquel appartiendront les services media (arr stack, jellyfin etc)";
      };
    };

    soft = {
      zen.enable = lib.mkEnableOption "Enable Zen browser";
      sops-nix.enable = lib.mkEnableOption "Enable secrets management with sops-nix";

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
    # not usefull right now
    homeManagerOnly = lib.mkEnableOption "For standalone home-manager";
  };
}
