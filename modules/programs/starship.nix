_: {
  flake.modules.homeManager.shell-starship = {
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
