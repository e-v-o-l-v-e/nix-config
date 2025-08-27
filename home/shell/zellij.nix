{ pkgs, config, ... }: {
  programs.zellij = {
    enableFishIntegration = true;
    attachExistingSession = false;
    exitShellOnExit = false;
  };

  home.packages = [
    (pkgs.writeScriptBin "theme-zellij-init" ''
      #!/usr/bin/env fish

      set -U THEME_ZELLIJ_LIGHT "ayu_light"
      set -U THEME_ZELLIJ_DARK "ao"
    '')
  ];
}
