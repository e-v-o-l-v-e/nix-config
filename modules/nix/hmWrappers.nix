{ inputs, config, ... }:
{
  imports = [
    inputs.hm-wrapper-modules.flakeModules.default
  ];

  hmWrappers.home-manager = inputs.home-manager;

  perSystem =
    { pkgs, ... }:
    {
      hmWrappers.programs = {
        starship = {
          mainPackage = pkgs.starship;
          homeModules = [ config.flake.modules.homeManager.starship ];
        };

        # Compose multiple HM modules — stylix auto-themes alacritty
        fish = {
          mainPackage = pkgs.fish;
          homeModules = [
            config.flake.modules.homeManager.fish
            config.flake.modules.homeManager.cli-core
            config.flake.modules.homeManager.cli-utils
          ];
        };
      };
    };
}
