{lib, ...}:
with lib; {
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
      enable = mkEnableOption "Enable gui and allow important packages";
      hyprland.enable = mkEnableOption "Enable hyprland and related packages for my config";
    };

    gaming = {
      enable = mkEnableOption "Enable basic gaming support";
      full = mkEnableOption "Enable full gaming stack (e.g. Heroic, gamescope etc)";
    };
  };
}
