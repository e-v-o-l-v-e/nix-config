{
  description = "My confiiiiig";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      # url = "github:nix-community/home-manager/release-24.11";
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
    ags = {
      url = "github:aylur/ags/v1"; # aylurs-gtk-shell-v1
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    nvf,
    ...
  }: let
    system = "x86_64-linux";
    username = "evolve";

    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };

    sharedArgs = {
      inherit inputs;
      inherit self;
      inherit system;
      inherit username;
    };
  in {
    # Waylander's nixos config.
    nixosConfigurations = {
      waylander = nixpkgs.lib.nixosSystem {
        specialArgs =
          sharedArgs
          // {
            hostname = "waylander";
          };
        modules = [
          ./hosts/waylander
          ./modules/nixos

          home-manager.nixosModules.home-manager.home-manager
          {
            userGlobalPkgs = true;
            useUserPackages = true;
            users.${username} = import ./modules/HM;
            extraSpecialArgs =
              sharedArgs
              // {
                hostname = "waylander";
              };
          }
        ];
      };

      druss = nixpkgs.lib.nixosSystem {
        specialArgs =
          sharedArgs
          // {
            hostname = "druss";
            full = true;
          };
        modules = [
          ./hosts/druss/config.nix
        ];
      };
    };

    # home-manager configs.
    homeConfigurations = {
      waylander = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./modules/HM];
        extraSpecialArgs =
          sharedArgs
          // {
            hostname = "waylander";
          };
      };

      druss = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./modules/HM];
        extraSpecialArgs =
          sharedArgs
          // {
            hostname = "druss";
          };
      };

      # home-manager config.
      min = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./modules/HM];
        extraSpecialArgs =
          sharedArgs
          // {
            inherit username;
            hostname = "min";
          };
      };

      delnoch = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./modules/HM];
        extraSpecialArgs =
          sharedArgs
          // {
            hostname = "delnoch";
          };
      };
    };

    # Neovim config.
    packages.x86_64-linux.my-neovim =
      (nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [./nvf.nix];
      })
      .neovim;

    packages.x86_64-linux.default = self.packages.x86_64-linux.my-neovim;

    # shells
    devShells.${system} = import ./shells.nix {inherit pkgs;};
  };
}
