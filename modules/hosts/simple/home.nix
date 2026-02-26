{ inputs, ... }:
let
  username = "evolve";
  hostname = "simple";
  system = "x86_64-linux";
  stateVersion = "26.05";
in
{
  flake.homeConfigurations = inputs.self.lib.mkHomeManager {
    inherit
      username
      hostname
      system
      stateVersion
      ;
  };

  flake.modules.homeManager."${hostname}" = {
    imports = [
      inputs.self.modules.homeManager.cli-core
      inputs.self.modules.homeManager.cli-utils
    ];

    programs.home-manager.enable = true;
    programs.man.generateCaches = false;
  };
}
