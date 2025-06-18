{
  pkgs,
  config,
  ...
}:
{
  services = {
    greetd = {
      enable = config.login-manager == "greetd";
      vt = 3;
      settings = {
        default_session = {
          user = config.username;
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland"; # start Hyprland with a TUI login manager
        };
      };
    };

    displayManager = {
      enable = config.login-manager == "sddm";
      sddm = {
        enable = config.login-manager == "sddm";
      };
    };
  };

  security.pam.services.swaylock = {
    text = ''
      guth include login
    '';
  };
}
