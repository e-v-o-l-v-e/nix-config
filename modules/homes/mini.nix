{ config, inputs, pkgs, ... }:
let
  inherit (config.meta) username;
in
{
  flake.homeConfigurations.mini = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = pkgs;
    modules = [
      inputs.self.modules.homeManager.miniHome
    ];
  };

  flake.modules.homeManager.miniHome = {
    inherit username;
    homeDirectory = "/home/${username}";

    nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    imports = [
      inputs.self.modules.homeManager.fish
    ];

    programs.home-manager.enable = true;
    home.stateVersion = "26.05";
  };
}
