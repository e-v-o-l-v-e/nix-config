{
  flake.modules.homeManager.starship =
    { pkgs, ... }:
    {
      programs.starship = {
        enable = true;
        enableFishIntegration = true;
      };

      home.packages = [ pkgs.starship ];
    };
}
