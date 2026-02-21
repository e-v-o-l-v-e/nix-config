_: {
  flake.modules.homeManager.lsd = {
    programs.lsd = {
      enable = true;
    };
  };

  flake.modules.homeManager.fish = {
    programs.lsd = {
      enableFishIntegration = false;
    };
  };
}
