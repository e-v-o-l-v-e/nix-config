_: {
  flake.modules.homeManager.nix-index = {
    programs.nix-index = {
      enable = true;
    };
  };

  flake.modules.homeManager.fish = {
    programs.nix-index = {
      enableFishIntegration = true;
    };
  };
}
