{
  description = "My confiiiiig";

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nvf,
      zen-browser,
      stylix,
      ...
    }:
    let
      username = "evolve";
      system = "x86_64-linux";
      flakePath = "/home/${username}/nix-config";

      colorscheme = {
        dark = "gruvbox-dark-medium";
        light = "one-light";
        light1 = "atelier-dune-light";
        light2 = "gruvbox-light-hard";
      };


      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

      hostConfigurations = {
        # my battlestation
        druss = {
          gaming = {
            enable = true;
            full = true;
          };
          gui = {
            enable = true;
            plasma.enable = true;
            stylix = {
              enable = true;
              theme = colorscheme.dark;
            };
          };
        };

        # my laptop
        waylander = {
          laptop = true;
          gaming.enable = true;
          gui = {
            enable = true;
            hyprland = true;
            stylix = {
              enable = true;
              theme = colorscheme.light;
            };
            quickshell.enable = true;

          };
        };

        # my server
        delnoch = {
          server = true;
        };
      };

      mkSystemConfig = hostname:
        nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          specialArgs = {
            inherit inputs self hostname username;
            hostConfig = hostConfigurations.${hostname} or { };
          };

          modules = [
            ./hosts/${hostname}
            ./system
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "";
                users.${username} = {
                  imports = [
                    ./home
                    stylix.homeModules.stylix
                  ];
                  _module.args = {
                    inherit inputs self hostname;
                    hostConfig = hostConfigurations.${hostname} or { };
                  };
                };
              };
            }
          ];
        };

      mkHomeConfig =
        hostname:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home
            stylix.homeModules.stylix
          ];
          extraSpecialArgs = {
            inherit
              inputs
              self
              hostname
              username
              ;
            hostConfig = hostConfigurations.${hostname} or { };
          };
        };
    in
    {
      # NIXOS CONFIGURATIONS
      nixosConfigurations = {
        waylander = mkSystemConfig "waylander";
        druss = mkSystemConfig "druss";
        wsl = mkSystemConfig "wsl";
        delnoch = mkSystemConfig "delnoch";
      };

      # HOME-MANAGER CONFIGURATIONS.
      homeConfigurations = {
        waylander = mkHomeConfig "waylander";
        druss = mkHomeConfig "druss";
        delnoch = mkHomeConfig "delnoch";
        wsl = mkHomeConfig "wsl";
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
