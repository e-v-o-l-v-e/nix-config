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
          config.gui.theme = "light";
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
          config.gui.theme = "light";
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

    # parseHostTheme = fullHost: let
    #   parts = builtins.match "^(.*?)(?:-(dark|light))?$" fullHost;
    # in {
    #   hostname = parts[0];
    #   theme = if parts[1] != null then parts[1] else "light";
    # };

    parseHostTheme = fullHost: let
      parts = builtins.match "^(.*)-dark$" fullHost;
    in 
      if parts != null then {
      hostname = parts[0];
      theme = "dark";
    } else (let
        parts2 = builtins.match "^(.*)-light$" fullHost;
      in if parts2 != null then {
        hostname = parts2[0];
        theme = "light";
      } else {
        hostname = fullHost;
        theme = "light";
      }
    );

  in {
    # NIXOS CONFIGURATIONS
    nixosConfigurations = nixpkgs.lib.genAttrs myHosts mkSystemConfig;
    # nixosConfigurations = nixpkgs.lib.genAttrs myHosts (hostStr:
    #   let parsed = parseHostTheme hostStr;
    #   in mkSystemConfig parsed.hostname parsed.theme
    # );


    # HOME-MANAGER CONFIGURATIONS.
    homeConfigurations = builtins.listToAttrs (
      builtins.map (host: {
        name = "${username}@${host}";
        value = mkHomeConfig host;
      })
      myHosts
    );

  #   homeConfigurations = builtins.listToAttrs (
  #   builtins.map (hostStr:
  #     let parsed = parseHostTheme hostStr;
  #     in {
  #       name = "${username}@${parsed.hostname}";
  #       value = mkHomeConfig parsed.hostname parsed.theme;
  #     }
  #   ) myHosts
  # );


    # import shells
    devShells.${system} = import ./shells.nix {inherit pkgs;};
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

    copyparty = {
      url = "github:9001/copyparty";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
