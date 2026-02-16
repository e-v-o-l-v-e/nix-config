{
  description = "template using my fish config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Replace with your actual username and repository name
    evolve.url = "github:e-v-o-l-v-e/nix-config/flake-parts";
  };

  outputs =
    inputs@{ nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      username = "evolve";
    in
    {
      homeConfigurations."evolve" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          # 1. Import the exported module from your other flake
          inputs.evolve.homeModules.fish

          # 2. Basic Home Manager setup
          {
            config = {
              home = {
                inherit username;
                homeDirectory = "/home/${username}";
                stateVersion = "26.05"; # Match your current system
              };
              programs.home-manager.enable = true;
            };

            # 3. Provide the 'preferences.username' option that your fish module expects
            # Since your original flake defined this option in flake-parts,
            # you must set it here so 'config.preferences.username' resolves.
            options.preferences.username = nixpkgs.lib.mkOption {
              type = nixpkgs.lib.types.str;
              default = username;
            };
          }
        ];
      };
    };
}
