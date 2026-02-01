{ withSystem, inputs, ... }: {
  perSystem = { system, ... }: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      # overlays = [ inputs.foo.overlays.default ]; # TODO add caddy cloudflare overlay
      config = {
        allowUnfree = true;
      };
    };
  };

  flake.nixosConfigurations.my-machine = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      ./configuration.nix
      inputs.nixpkgs.nixosModules.readOnlyPkgs
      ({ config, ... }: {
        # Use the configured pkgs from perSystem
        nixpkgs.pkgs = withSystem config.nixpkgs.hostPlatform.system (
          { pkgs, ... }: # perSystem module arguments
          pkgs
        );
      })
    ];
  };
}
