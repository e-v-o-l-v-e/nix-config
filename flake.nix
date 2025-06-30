{
  description = "My confiiiiig";

  outputs =
    inputs@{
      self,
      nixpkgs,
      zen-browser,
      stylix,
      home-manager,
      nvf,
      sops-nix,
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

      mkSystemConfig =
        hostname: username:
        nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          specialArgs = {
            inherit
              hostname
              username
              self
              inputs
              ;
          };
          modules = [
            ./options.nix
            ./hosts/${hostname}
            ./system

            inputs.stylix.nixosModules.stylix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                users.${username} = {
                  imports = [
                    zen-browser.homeModules.twilight
                    nvf.homeManagerModules.default

                    ./options.nix
                    ./hosts/${hostname}/configuration.nix
                    ./home
                  ];
                };
                extraSpecialArgs = {
                  inherit
                    inputs
                    self
                    hostname
                    username
                    system
                    ;
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
            stylix.homeModules.stylix
            zen-browser.homeModules.twilight
            nvf.homeManagerModules.default

            ./options.nix
            ./hosts/${hostname}/configuration.nix
            ./home
          ];
          extraSpecialArgs = {
            inherit
              inputs
              self
              hostname
              username
              ;
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
      };

      # HOME-MANAGER CONFIGURATIONS.
      homeConfigurations = {
        waylander = mkHomeConfig "waylander" username;
        druss = mkHomeConfig "druss" username;
        delnoch = mkHomeConfig "delnoch" username;
        # wsl = mkHomeConfig "wsl";
      };

      # package Neovim config (nvf)
      # packages.x86_64-linux = {
      #   nvf-max =
      #     let
      #       maxConfig = import ./nvf.nix true;
      #     in
      #     (nvf.lib.neovimConfiguration {
      #       pkgs = nixpkgs.legacyPackages.x86_64-linux;
      #       modules = [ maxConfig ];
      #     }).neovim;
      #
      #   nvf-min =
      #     let
      #       minConfig = import ./nvf.nix false;
      #     in
      #     (nvf.lib.neovimConfiguration {
      #       pkgs = nixpkgs.legacyPackages.x86_64-linux;
      #       modules = [ minConfig ];
      #     }).neovim;
      #   # set nvf minimal config as default package
      #   default = self.packages.x86_64-linux.nvf-max;
      # };

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
