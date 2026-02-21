{
  inputs,
  lib,
  config,
  ...
}:
let
  defaultUsername = "evolve";
  defaultHMConf = "mini";
  defaultSystem = "x86_64-linux";
  defaultHMStateVersion = "26.05";
in
{
  # Helper functions for creating system / home-manager / user configurations

  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };

  config.flake.lib = {

    mkNixos =
      system: name:
      inputs.nixpkgs.lib.nixosSystem {
        modules = [
          inputs.self.modules.nixos.${name}
          { nixpkgs.hostPlatform = lib.mkDefault system; }
        ];
      };

    mkHomeManager =
      {
        username ? defaultUsername,
        conf ? defaultHMConf,
        system ? defaultSystem,
        stateVersion ? defaultHMStateVersion,
        ...
      }:
      {
        ${username} = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages.${system};
          modules = [
            inputs.self.modules.homeManager.${conf}
            {
              nixpkgs.config.allowUnfree = true;
              nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
              home = {
                inherit username stateVersion;
                homeDirectory = "/home/${username}";
                sessionPath = [
                  "$HOME/.local/bin"
                ];
              };
            }
          ];
        };
      };
  };
}
