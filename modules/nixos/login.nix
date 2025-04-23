{
  pkgs,
  username,
  login,
  ...
}: {
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

    displayManager.sddm = {
      enable = login == "sddm";
    };
  };
}
