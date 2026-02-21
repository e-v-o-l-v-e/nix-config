{
  inputs,
  lib,
  config,
  ...
}:
let
  defaultUsername = "evolve";
  defaultHostname = "mini";
  defaultSystem = "x86_64-linux";
  defaultStateVersion = "26.05";
in
{
  # Helper functions for creating system / home-manager / user configurations

  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };

  config.flake.lib = {

    mkNixos =
      {
        hostname ? defaultHostname,
        system ? defaultSystem,
        stateVersion ? defaultStateVersion,
        ...
      }:
      inputs.nixpkgs.lib.nixosSystem {
        modules = [

          inputs.self.modules.nixos.${hostname}

          # default stuff
          inputs.self.modules.nixos.appimage
          inputs.self.modules.nixos.boot
          inputs.self.modules.nixos.kernel
          inputs.self.modules.nixos.keyboard
          inputs.self.modules.nixos.nh

          {
            nixpkgs.hostPlatform = lib.mkDefault system;
            networking.hostName = hostname;
            system = {
              inherit stateVersion;
            };
          }
        ];
      };

    mkHomeManager =
      {
        username ? defaultUsername,
        hostname ? defaultHostname,
        system ? defaultSystem,
        stateVersion ? defaultStateVersion,
        ...
      }:
      {
        ${username} = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages.${system};
          modules = [
            inputs.self.modules.homeManager.${hostname}
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
