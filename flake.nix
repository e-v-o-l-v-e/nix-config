{
  description = "My confiiiiig";

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    username = "evolve";
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };

    mkSystemConfig = hostname:
      nixpkgs.lib.nixosSystem {
        inherit system pkgs;

        specialArgs = {
          inherit hostname username self inputs;
          HM = false;
        };

        modules = importModulesNixos hostname;
      };

    mkHomeConfig = hostname:
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = importModulesHM hostname;

        extraSpecialArgs = {
          inherit hostname username self inputs system;
          homeManagerOnly = true;
          HM = true;
        };
      };

    importModulesNixos = hostname: [
      ./options.nix
      ./hosts/${hostname}
      ./system

      inputs.stylix.nixosModules.stylix
    ];

    importModulesHM = hostname: [
      ./options.nix
      ./hosts/${hostname}/configuration.nix
      ./home

      inputs.zen-browser.homeModules.twilight
      inputs.nvf.homeManagerModules.default
      inputs.stylix.homeModules.stylix
    ];

    myHosts = builtins.attrNames (builtins.readDir ./hosts);
  in {
    # NIXOS CONFIGURATIONS
    nixosConfigurations = nixpkgs.lib.genAttrs myHosts mkSystemConfig;

    # HOME-MANAGER CONFIGURATIONS.
    # homeConfigurations = nixpkgs.lib.genAttrs myHosts mkHomeConfig;
    homeConfigurations = builtins.listToAttrs (
      builtins.map (host: {
        name = "${username}@${host}";
        value = mkHomeConfig host;
      })
      myHosts
    );

    # import shells
    devShells.${system} = import ./shells.nix {inherit pkgs;};
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-local.url = "git+"

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
