{
  inputs,
  config,
  ...
}:
let
  username = "evolve";
  system = "x86_64-linux";
  stateVersion = "26.05";
in
{
  flake.homeConfigurations = inputs.self.lib.mkHomeManager {
    inherit username system stateVersion;
  };

  flake.modules.homeManager.mini =
    { pkgs, config, ... }:
    {
      home = {
        inherit username;
        homeDirectory = "/home/${username}";
      };

      imports = [
        inputs.self.modules.homeManager.shell
      ];

      programs.home-manager.enable = true;
      programs.man.generateCaches = false;
    };
}
