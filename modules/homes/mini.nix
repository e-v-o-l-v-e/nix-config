{ inputs, ... }:
let
  username = "evolve";
  conf = "mini";
  system = "x86_64-linux";
  stateVersion = "26.05";
in
{
  flake.homeConfigurations = inputs.self.lib.mkHomeManager {
    inherit
      username
      conf
      system
      stateVersion
      ;
  };

  flake.modules.homeManager.mini = {
    imports = [
      inputs.self.modules.homeManager.cli-core
    ];

    programs.home-manager.enable = true;
    programs.man.generateCaches = false;
  };
}
