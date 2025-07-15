{ config, ... }: {
  programs.btop = {
    enable = true;

    settings.color_theme = 
      if config.gui.theme == "light"
        then "gruvbox_light"
      else "gruvbox_dark";
  };
}
