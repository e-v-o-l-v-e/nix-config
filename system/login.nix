{
  pkgs,
  hostConfig,
  ...
}:
{
  services = {
    greetd = {
      enable = hostConfig.login-manager == "greetd";
      vt = 3;
      settings = {
        default_session = {
          user = hostConfig.username;
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland"; # start Hyprland with a TUI login manager
        };
      };
    };

    displayManager = {
      enable = hostConfig.login-manager == "sddm";
      sddm = {
        enable = hostConfig.login-manager == "sddm";
      };
    };
  };

  security.pam.services.swaylock = {
    text = ''
      guth include login
    '';
  };
}
