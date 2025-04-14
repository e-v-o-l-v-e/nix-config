{
  description = "My confiiiiig";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
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
    zen-browser,
    nvf,
    ags,
    ...
  }: let
    system = "x86_64-linux";
    username = "evolve";
    isNixos = false;

    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in {
    # Waylander's nixos config.
    nixosConfigurations = {
      waylander = nixpkgs.lib.nixosSystem rec {
        specialArgs = {
          inherit system;
          inherit inputs;
          inherit username;
          inherit self;
          isNixos = true;
          hostname = "waylander";
        };
        modules = [
          ./hosts/waylander
        ];
      };

      druss = nixpkgs.lib.nixosSystem rec {
        specialArgs = {
          inherit system;
          inherit inputs;
          inherit username;
          inherit self;
          isNixos = true;
          hostname = "druss";
        };
        modules = [
          ./hosts/druss/config.nix
        ];
      };
    };

    # home-manager config.
    homeConfigurations.waylander = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [./hosts/waylander/home.nix];
      extraSpecialArgs = {
        inherit self;
        inherit username;
        inherit isNixos;
        inherit inputs;
      };
    };

    # home-manager config.
    homeConfigurations.druss = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [./hosts/druss/home.nix];
      extraSpecialArgs = {
        inherit self;
        inherit username;
        inherit isNixos;
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
  };
}
