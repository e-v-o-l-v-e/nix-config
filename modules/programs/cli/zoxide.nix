_: {
  flake.modules.homeManager.zoxide = {
    programs.zoxide = {
      enable = true;

      options = [
        "--cmd cd"
      ];
    };
  };

  flake.modules.homeManager.fish = {
    programs.zoxide = {
      enableFishIntegration = true;
    };
  };
}
