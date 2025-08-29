{
  description = "My confiiiiig";

  outputs =
    inputs@{
      self,
      nixpkgs,
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

      mkSystemConfig =
        hostname:
        nixpkgs.lib.nixosSystem {
          inherit system pkgs;

          specialArgs = {
            inherit
              hostname
              username
              self
              inputs
              ;
            HM = false;
          };

          modules = importModulesNixos hostname;
        };

      mkHomeConfig =
        hostname:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = importModulesHM hostname;

          extraSpecialArgs = {
            inherit
              hostname
              username
              self
              inputs
              system
              ;
            homeManagerOnly = true;
            HM = true;
          };
        };

      importModulesNixos = hostname: [
        ./options.nix
        ./hosts/${hostname}
        ./system

        inputs.vpn-confinement.nixosModules.default
      ];

      importModulesHM = hostname: [
        ./options.nix
        ./hosts/${hostname}/configuration.nix
        ./home

        inputs.zen-browser.homeModules.twilight
        inputs.nvf.homeManagerModules.default
      ];

      myHosts = builtins.attrNames (builtins.readDir ./hosts);
    in
    {
      # NIXOS CONFIGURATIONS
      nixosConfigurations = nixpkgs.lib.genAttrs myHosts mkSystemConfig;

      # HOME-MANAGER CONFIGURATIONS.
      homeConfigurations = builtins.listToAttrs (
        builtins.map (host: {
          name = "${username}@${host}";
          value = mkHomeConfig host;
        }) myHosts
      );

      # import shells
      devShells.${system} = import ./custom/shells.nix { inherit pkgs; };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # nixpkgs.url = "git+file:///home/evolve/Code/nixpkgs?ref=nixos-local-content-share-init";

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

    copyparty = {
      url = "github:9001/copyparty";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vpn-confinement.url = "github:Maroka-chan/VPN-Confinement";

    local-content-share = {
      url = "github:e-v-o-l-v-e/local-content-share";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ignis = {
      url = "github:ignis-sh/ignis";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
