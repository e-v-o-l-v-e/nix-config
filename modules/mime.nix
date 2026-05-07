{
  flake.modules.homeManager.mime = {
    xdg.mimeApps = {
      enable = true;
      defaultApplications =
        let
          zen = "zen-twilight.desktop";
        in
        {
          "application/pdf" = [
            "zathura.desktop"
            zen
          ];
          "x-scheme-handler/http" = zen;
          "x-scheme-handler/https" = zen;
          "x-scheme-handler/chrome" = zen;
          "text/html" = zen;
          "application/x-extension-htm" = zen;
          "application/x-extension-html" = zen;
          "application/x-extension-shtml" = zen;
          "application/xhtml+xml" = zen;
          "application/x-extension-xhtml" = zen;
          "application/x-extension-xht" = zen;
          "x-scheme-handler/discord" = "vesktop.desktop";
        };
    };
  };
}
