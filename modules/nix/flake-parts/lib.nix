{
  inputs,
  lib,
  config,
  ...
}:
let
  defaultUsername = "evolve";
  defaultSystem = "x86_64-linux";
  defaultHMStateVersion = "26.05";
  defaultHMConf = "mini";
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
        system ? defaultSystem,
        conf ? defaultHMConf,
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
              };
            }
          ];
        };
      };

    mkUser = username: isAdmin: {
      nixos."${username}" =
        { lib, pkgs, ... }:
        {
          users.users."${username}" = {
            isNormalUser = true;
            home = "/home/${username}";
            extraGroups = [
              # TODO modularise
              "audio"
              "docker"
              "input"
              "inputs"
              "key"
              "kvm"
              "libvirtd"
              "lp"
              "networkmanager"
              "scanner"
              "uinputs"
              "users"
              "video"
              "wheel"
            ]
            ++ lib.optional isAdmin "wheel";

            shell = pkgs.fish;
          };
          programs.fish.enable = true;

          home-manager.users."${username}" = {
            imports = [
              inputs.self.modules.homeManager."${username}"
            ];
          };
        };

      homeManager."${username}" = {
        home.username = "${username}";
      };
    };
  };
}
