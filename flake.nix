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
    isNixos = nixpkgs.lib.mkDefault false;

    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };

    sharedArgs = {
      inherit system;
      inherit inputs;
      inherit username;
      inherit self;
      inherit isNixos;
    };
  in {
    # Waylander's nixos config.
    nixosConfigurations = {
      waylander = nixpkgs.lib.nixosSystem {
        specialArgs =
          sharedArgs
          // {
            isNixos = true;
            hostname = "waylander";
          };
        modules = [
          ./hosts/waylander

          home-manager.nixosModules.home-manager.home-manager
          {
            userGlobalPkgs = true;
            useUserPackages = true;
            users.evolve = import ./hosts/waylander/home.nix;
          }
        ];
      };

      druss = nixpkgs.lib.nixosSystem {
        specialArgs =
          sharedArgs
          // {
            isNixos = nixpkgs.lib.mkForce true;
            hostname = "druss";
          };
        modules = [
          ./hosts/druss/config.nix
        ];
      };
    };

    # home-manager config.
    homeConfigurations = {
      waylander = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./hosts/waylander/home.nix];
        extraSpecialArgs =
          sharedArgs
          // {
            inherit isNixos;
            inherit inputs;
            inherit system;
          };
      };

      # home-manager config.
      druss = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./hosts/druss/home.nix];
        extraSpecialArgs = {
          inherit self;
          inherit username;
          inherit isNixos;
        };
      };
    };
    # Neovim config.
    packages.x86_64-linux.my-neovim =
      (nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [./modules/nvf.nix];
      })
      .neovim;

    packages.x86_64-linux.default = self.packages.x86_64-linux.my-neovim;

    # shells
    devShells.${system} = import ./shells.nix {inherit pkgs;};
  };
}
