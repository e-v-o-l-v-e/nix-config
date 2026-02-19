{
  description = "HM config template, default: mini";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    evolve.url = "github:e-v-o-l-v-e/nix-config/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ evolve, ... }:
    let
      username = "evolve";
      system = "x86_64-linux";
      conf = "mini";
    in
    {
      homeConfigurations = evolve.lib.mkHomeManager {
        inherit username system conf;
      };
    };
}
