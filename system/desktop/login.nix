{
  lib,
  pkgs,
  config,
  username,
  ...
}:
let
  lm = config.login-manager;
in
{
  config = lib.mkIf (lm != null) {
    services = {
      greetd = {
        enable = lm == "greetd";
        settings = {
          default_session = {
            user = username;
            command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd start-hyprland"; # start Hyprland with a TUI login manager
          };
        };
      };

      displayManager = lib.mkIf (lm == "sddm" || lm == "gdm") {
        enable = true;
        sddm.enable = lm == "sddm";
        gdm.enable = lm == "gdm";
      };
    };

    security.pam.services.swaylock = lib.mkIf (!config.server.enable) {
      text = ''
        guth include login
      '';
    };
  };

  options = {
    login-manager = lib.mkOption {
      type = lib.types.enum [
        "greetd"
        "sddm"
        "gdm"
        null
      ];
      default = "greetd";
      description = "Which login manager to use, null for none";
    };
  };
}
