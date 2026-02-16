{ inputs, ... }:
{
  flake.modules.homeManager.shell-min = {
    imports = [
      inputs.self.modules.homeManager.shell-fish
      inputs.self.modules.homeManager.cli-core
    ];
  };

  flake.modules.homeManager.shell = {
    imports = [
      inputs.self.modules.homeManager.shell-fish
      inputs.self.modules.homeManager.shell-starship
      inputs.self.modules.homeManager.cli-core
      inputs.self.modules.homeManager.cli-utils
    ];
  };
}
