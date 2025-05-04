{
  pkgs,
  username,
  loginManager,
  lib,
  ...
}:
{
  services = {
    greetd = {
      enable = loginManager == "greetd";
      vt = 3;
      settings = {
        default_session = {
          user = username;
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland"; # start Hyprland with a TUI login manager
        };
      };
    };

    displayManager = {
      enable = loginManager != "";
      sddm = {
        enable = loginManager == "sddm";
      };
    };

  };
  security.pam.services.swaylock = {
    text = ''
      guth include login
    '';
  };
}
