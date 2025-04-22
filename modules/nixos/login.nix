{
  pkgs,
  hostname,
  username,
  ...
}: {
  services = {
    greetd = {
      enable = hostname == "waylander";
      vt = 3;
      settings = {
        default_session = {
          user = username;
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland"; # start Hyprland with a TUI login manager
        };
      };
    };
  };
}
