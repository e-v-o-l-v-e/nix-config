_: {
  flake.modules.homeManager.nix-index = {
    programs.nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
