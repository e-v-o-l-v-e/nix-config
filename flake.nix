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

    stylix.url = "github:danth/stylix";

    ags = {
      url = "github:aylur/ags/v1"; # aylurs-gtk-shell-v1
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

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
      system = "x86_64-linux";
      username = "evolve";

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

      variables = import ./variables.nix;
      getVar =
        hostname:
        nixpkgs.lib.recursiveUpdate variables.defaults (nixpkgs.lib.attrByPath [ hostname ] { } variables);

      sharedArgs = {
        inherit inputs;
        inherit self;
        inherit system;
        inherit username;
      };

      mkHomeConfig =
        hostname:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home
            stylix.homeModules.stylix
            zen-browser.homeModules.twilight
          ];
          extraSpecialArgs =
            sharedArgs
            // {
              inherit hostname;
            }
            // getVar hostname;
        };

      mkSystemConfig =
        hostname:
        nixpkgs.lib.nixosSystem {
          inherit pkgs;
          inherit system;
          specialArgs =
            sharedArgs
            // {
              inherit hostname;
            }
            // getVar hostname;

          modules = [
            ./hosts/${hostname}
            ./system
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                users.${username} = import ./home;
                extraSpecialArgs =
                  sharedArgs
                  // {
                    inherit hostname;
                  }
                  // getVar hostname;
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "";
              };
            }
          ];
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
}
