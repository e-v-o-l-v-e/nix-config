{
  description = "My confiiiiig";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    ags.url = "github:aylur/ags/v1"; # aylurs-gtk-shell-v1
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    zen-browser,
    ags,
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
  in {
    nixosConfigurations = {
      "waylander" = nixpkgs.lib.nixosSystem rec {
        specialArgs = {
          inherit system;
          inherit inputs;
          inherit username;
        };
        modules = [
          ./hosts/waylander/config.nix
          {
            environment.systemPackages = [
              inputs.zen-browser.packages."${system}".default
            ];
          }
        ];
      };
    };
  };
}
