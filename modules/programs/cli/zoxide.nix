_: {
  flake.modules.homeManager.zoxide = {
    programs.zoxide = {
      enable = true;

      options = [
        "--cmd cd"
      ];

      enableFishIntegration = true;
    };
  };
}
