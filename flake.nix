{
  description = "My confiiiiig";

  outputs = inputs@{ self, nixpkgs, home-manager, nvf, ...
    }:
    let
      configuration = import ./configuration.nix;
      inherit (configuration) hostConfigurations;

      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

      mkSystemConfig = hostname: nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          specialArgs = {
            inherit inputs self hostname;
            hostConfig = hostConfigurations.${hostname};
            inherit (hostConfigurations.${hostname}) username;
          };

          modules = [
            ./options.nix
            ./hosts/${hostname}
            ./system
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "";
                users.${hostConfigurations.${hostname}.username} = {
                  imports = [
                    ./options.nix
                    ./home
                  ];
                  _module.args = {
                    inherit inputs self hostname;
                    hostConfig = hostConfigurations.${hostname};
                  };
                };
              };
            }
          ];
        };

      mkHomeConfig = hostname: home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./options.nix
            ./home
          ];
          extraSpecialArgs = {
            inherit inputs self hostname;
            inherit (hostConfigurations.${hostname}) username;
            hostConfig = hostConfigurations.${hostname};
          };
        };
    in
    {
      # NIXOS CONFIGURATIONS
      nixosConfigurations = {
        waylander = mkSystemConfig "waylander";
        druss = mkSystemConfig "druss";
        delnoch = mkSystemConfig "delnoch";
        # wsl = mkSystemConfig "wsl";
      };

      # HOME-MANAGER CONFIGURATIONS.
      homeConfigurations = {
        waylander = mkHomeConfig "waylander";
        druss = mkHomeConfig "druss";
        delnoch = mkHomeConfig "delnoch";
        # wsl = mkHomeConfig "wsl";
      };

      # package Neovim config (nvf)
      packages.x86_64-linux = {
        nvf-max =
          let
            maxConfig = import ./nvf.nix true;
          in
          (nvf.lib.neovimConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            modules = [ maxConfig ];
          }).neovim;

        nvf-min =
          let
            minConfig = import ./nvf.nix false;
          in
          (nvf.lib.neovimConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            modules = [ minConfig ];
          }).neovim;
        # set nvf minimal config as default package
        default = self.packages.x86_64-linux.nvf-max;
      };

      # import shells
      devShells.${system} = import ./shells.nix { inherit pkgs; };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
  };
}
