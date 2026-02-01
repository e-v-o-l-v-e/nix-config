{ inputs, lib, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.home-manager.flakeModules.home-manager
  ];

  config = {
    systems = [
      "x86_64-linux"
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
    ];
  };

  options = {
    meta = {
      username = lib.mkOption {
        type = lib.types.str;
        default = "evolve";
      };
    };
  };
}
