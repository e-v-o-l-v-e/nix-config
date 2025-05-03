{
  pkgs,
  username,
  login,
  lib,
  ...
}:
{
  services = {
    greetd = {
      enable = login == "greetd";
      vt = 3;
      settings = {
        default_session = {
          user = username;
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland"; # start Hyprland with a TUI login manager
        };
      };
    };

    displayManager = {
      enable = login != "";
      sddm = {
        enable = login == "sddm";
      };
    };

  };
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
}
