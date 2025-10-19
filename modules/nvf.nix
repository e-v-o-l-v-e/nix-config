{ inputs, lib, ... }:
{
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  flake-file = {
    description = "nvf input";
    inputs.nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
