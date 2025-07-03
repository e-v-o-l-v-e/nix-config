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
  config = {
    services = {
      greetd = {
        enable = lm == "greetd";
        vt = 3;
        settings = {
          default_session = {
            user = username;
            command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland"; # start Hyprland with a TUI login manager
          };
        };
      };

      displayManager = lib.mkIf (lm == "sddm") {
        enable = true;
        sddm = {
          enable = true;
        };
      };
    };

    security.pam.services.swaylock = lib.mkIf (!config.server.enable) {
      text = ''
        guth include login
      '';
    };

    options = {
      login-manager = lib.mkOption {
        type = lib.types.enum [
          "greetd"
          "sddm"
        ];
        default = "greetd";
        description = "Which login manager to use, null for none";
      };
    };
  };
}
