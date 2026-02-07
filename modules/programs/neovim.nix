{ pkgs, inputs, ... }:
{
  flake.modules.homeManager = {
    nvim = {
      imports = [
        inputs.self.modules.homeManager.cli-nvim
        inputs.self.modules.homeManager.cli-nix
      ];
    };

    nvim-min = {
      imports = [
        inputs.self.modules.homeManager.cli-nvim
      ];
    };
  };
}
