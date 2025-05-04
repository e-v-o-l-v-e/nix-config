{
  defaults = {
    DE = [ ]; # "hyprland" and/or "plasma"
    gaming = "none"; # one of [ "none" "simple" "full" ]
    personal = true; # set personal config and packages. like zen-browser, stylix config etc
    server = false; # docker etc
    colorScheme = ""; # set colorScheme, https://tinted-theming.github.io/tinted-gallery/
    loginManager = ""; # which loginmanager to use, "greetd" or "sddm"
  };

  waylander = {
    gaming = "simple";
    DE = [ "hyprland" ];
    loginManager = "greetd";
    colorScheme = "emil";
  };

  druss = {
    colorScheme = "gruvbox-dark-hard";
    gaming = "full";
    DE = [
      "plasma"
      "hyprland"
    ];
    loginManager = "sddm";
  };

  delnoch = {
    personal = false;
    gaming = "none";
    DE = [ ];
    server = true;
  };

  wsl = {
    personal = false;
  };
}
