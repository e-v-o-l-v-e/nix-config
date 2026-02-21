{ inputs, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.home-manager.flakeModules.home-manager
  ];

  config = {
    debug = true;

    systems = [
      "x86_64-linux"
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
    ];
  };
}
