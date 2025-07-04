{
  description = "My confiiiiig";

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-local,
      home-manager,
      ...
    }:
    let
      username = "evolve";
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

      upkgs = import nixpkgs-local {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

      mkSystemConfig =
        hostname: username:
        nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          specialArgs = {
            inherit hostname username self inputs;
          };
          modules = [
            ./hosts/${hostname}
            ./system

            inputs.stylix.nixosModules.stylix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                users.${username} = {
                  imports = [
                    inputs.zen-browser.homeModules.twilight
                    inputs.nvf.homeManagerModules.default

                    ./hosts/${hostname}/configuration.nix
                    ./home
                  ];
                };
                extraSpecialArgs = {
                  inherit inputs self hostname username system;
                };
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "";
              };
            }
          ];
        };

      mkSystemConfigTest =
        hostname: username:
        nixpkgs-local.lib.nixosSystem {
          inherit system;
          pkgs = upkgs;
          specialArgs = {
            inherit hostname username self inputs;
          };
          modules = [
            ./hosts/${hostname}
            ./system

            inputs.stylix.nixosModules.stylix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                users.${username} = {
                  imports = [
                    inputs.zen-browser.homeModules.twilight
                    inputs.nvf.homeManagerModules.default

                    ./hosts/${hostname}/configuration.nix
                    ./home
                  ];
                };
                extraSpecialArgs = {
                  inherit inputs self hostname username system;
                };
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "";
              };
            }
          ];
        };
      mkHomeConfig =
        hostname: username:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            inputs.stylix.homeModules.stylix
            inputs.zen-browser.homeModules.twilight
            inputs.nvf.homeManagerModules.default

            ./hosts/${hostname}/configuration.nix
            ./home
          ];
          extraSpecialArgs = {
            inherit inputs self hostname username;
            config.homeManagerOnly = true;
          };
        };
    in
    {
      # NIXOS CONFIGURATIONS
      nixosConfigurations = {
        waylander = mkSystemConfig "waylander" username;
        druss = mkSystemConfig "druss" username;
        delnoch = mkSystemConfig "delnoch" username;
        # wsl = mkSystemConfig "wsl";

        test = mkSystemConfigTest "test" username;
      };

      # HOME-MANAGER CONFIGURATIONS.
      homeConfigurations = {
        waylander = mkHomeConfig "waylander" username;
        druss = mkHomeConfig "druss" username;
        delnoch = mkHomeConfig "delnoch" username;
        # wsl = mkHomeConfig "wsl";
      };

      # import shells
      devShells.${system} = import ./shells.nix { inherit pkgs; };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-local.url = "git+file:///home/evolve/Code/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      # url = "github:aylur/ags/v1";
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    local-content-share = {
      url = "github:e-v-o-l-v-e/local-content-share";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
