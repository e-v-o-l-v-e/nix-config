_: {
  flake.modules.homeManager.lsd = {
    programs.lsd = {
      enable = true;
      enableFishIntegration = false;
    };
  };
}
