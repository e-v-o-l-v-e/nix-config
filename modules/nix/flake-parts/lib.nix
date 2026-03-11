{
  inputs,
  lib,
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
        modules = with inputs.self.modules.nixos; [
          inputs.self.modules.nixos."${hostname}"

          # default stuff
          appimage
          boot
          kernel
          keyboard
          nh
          nix
          locales

          {
            nixpkgs.config.allowUnfree = true;
            networking.hostName = hostname;
            nixpkgs.hostPlatform = lib.mkDefault system;
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
      inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${system};

        modules = [
          inputs.self.modules.homeManager.${hostname}
          inputs.self.modules.homeManager.${username} or { }
          inputs.self.modules.homeManager.nix
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
}
