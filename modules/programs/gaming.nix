{ inputs, ... }:
{
  flake.modules = {
    nixos = {
      steam =
        { pkgs, ... }:
        {
          programs.steam = {
            enable = true;
            gamescopeSession.enable = true;
            extraCompatPackages = with pkgs; [
              proton-ge-bin
            ];
          };
        };

      gaming = {
        imports = [
          inputs.self.modules.nixos.steam
        ];

        programs.gamemode.enable = true;
      };
    };

    homeManager = {
      steam =
        { pkgs, ... }:
        {
          home.packages = with pkgs; [
            steam
            steam-run
          ];
        };

      heroic =
        { pkgs, ... }:
        {
          home.packages = [ pkgs.heroic ];
        };

      gaming =
        { pkgs, ... }:
        {
          imports = [
            inputs.self.modules.homeManager.steam
            inputs.self.modules.homeManager.heroic
          ];
        };

      gamingFull =
        { pkgs, ... }:
        {
          imports = [
            inputs.self.modules.homeManager.heroic
            inputs.self.modules.homeManager.gaming
          ];

          home.packages = with pkgs; [
            wine
            umu-launcher
            vkd3d
            vkd3d-proton
            directx-headers
            ryubing
          ];
        };
    };
  };
}
