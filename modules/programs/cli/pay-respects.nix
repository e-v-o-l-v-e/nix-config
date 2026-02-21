_: {
  flake.modules.homeManager.pay-respects = {
    programs.pay-respects = {
      enable = true;
    };
  };

  flake.modules.homeManager.fish = {
    programs.pay-respects = {
      enableFishIntegration = true;
    };
  };
}
