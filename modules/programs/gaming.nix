{ self, ... }:
{
  flake.modules.nixos.steam =
    { pkgs, ... }:
    {
      programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
      };

      boot.kernel.sysctl = {
        # Needed for steam games
        "vm.max_map_count" = 2147483642;
      };

    };

  flake.modules.nixos.gaming = {
    imports = [
      self.modules.nixos.steam
    ];

    programs.gamemode.enable = true;
  };

  flake.modules.homeManager.steam =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        steam
        steam-run
      ];
    };

  flake.modules.homeManager.heroic =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.heroic ];
    };

  flake.modules.homeManager.gaming = {
    imports = [
      self.modules.homeManager.steam
      self.modules.homeManager.heroic
    ];
  };

  flake.modules.homeManager.gamingFull =
    { pkgs, ... }:
    {
      imports = [
        self.modules.homeManager.heroic
        self.modules.homeManager.gaming
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
}
