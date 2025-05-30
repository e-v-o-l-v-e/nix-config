let
  dark = "gruvbox-dark-medium";
  light1 = "atelier-dune-light";
  light2 = "gruvbox-light-hard";
in
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
    colorScheme = light2;
  };

  druss = {
    colorScheme = light1;
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
