{ inputs, ... }:
let
  hostname = "waylander";
  system = "x86_64-linux";
in
{
  flake.nixosConfigurations = inputs.self.lib.mkNixos {
    inherit hostname system;

  };

  flake.homeConfigurations = inputs.self.lib.mkHomeManager {
    inherit hostname system;
    stateVersion = "25.05";
  };

  flake.modules.nixos.waylander =
    { config, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        # user
        evolve

        # system
        nixos-core
        gpu-amd
        kanata

        # desktop
        hyprland

        # programs
        sops
      ];

      system.stateVersion = "25.11";
    };

  flake.modules.homeManager.waylander = {
    imports = with inputs.self.modules.homeManager; [
      # shell
      cli-core
      cli-utils
      cli-personal
      cli-nvim

      # desktop
      gui-common
      gui-personnal
      hyprland

      # programs
      nh
    ];

    inherit hostname;
  };
}
