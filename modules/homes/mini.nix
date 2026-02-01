{ config, self, inputs, pkgs, ... }:
let
  inherit (config.meta) username;
in
{
  flake.homeConfigurations.mini = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = pkgs;
    modules = [
      self.homeModules.miniHome
    ];
  };

  flake.homeModules.miniHome = {
    inherit username;
    homeDirectory = "/home/${username}";

    nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    imports = [
      self.homeModules.fish
    ];

    programs.home-manager.enable = true;
    home.stateVersion = "26.05";
  };
}
