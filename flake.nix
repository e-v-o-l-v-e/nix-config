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
      inherit pkgs;
      inherit self;
      inherit system;
      inherit username;
    };

    mkHomeConfig = hostname:
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./modules/HM];
        extraSpecialArgs = sharedArgs // {inherit hostname;};
      };

    mkSystemConfig = hostname:
      nixpkgs.lib.nixosSystem {
        inherit pkgs;
        inherit system;
        specialArgs = sharedArgs // {inherit hostname;};

        modules = [
          ./hosts/${hostname}
          ./modules/nixos
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              users.${username} = import ./modules/HM;
              extraSpecialArgs = sharedArgs // {inherit hostname;};
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
            };
          }
        ];
      };
  in {
    # NIXOS CONFIGURATIONS
    nixosConfigurations = {
      waylander = mkSystemConfig "waylander";
      druss = mkSystemConfig "druss";
      wsl = mkSystemConfig "wsl";
      delnoch = mkSystemConfig "delnoch";
      min = mkSystemConfig "min";
    };

    # HOME-MANAGER CONFIGURATIONS.
    homeConfigurations = {
      waylander = mkHomeConfig "waylander";
      druss = mkHomeConfig "druss";
      delnoch = mkHomeConfig "delnoch";
      wsl = mkHomeConfig "wsl";
      min = mkHomeConfig "min";
    };

    # package Neovim config (nvf)
    packages.x86_64-linux.my-neovim =
      (nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [./nvf.nix];
      })
      .neovim;
    # set neovim config as default package
    packages.x86_64-linux.default = self.packages.x86_64-linux.my-neovim;

    # import shells
    devShells.${system} = import ./shells.nix {inherit pkgs;};
  };
}
