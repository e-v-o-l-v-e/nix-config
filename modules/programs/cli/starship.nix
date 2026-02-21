_: {
  flake.modules.homeManager.starship = {
    programs.starship = {
      enable = true;
    };
  };

  flake.modules.homeManager.fish = {
    programs.starship = {
      enableFishIntegration = true;
    };
  };
}
