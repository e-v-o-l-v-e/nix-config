{
  inputs,
  config,
  ...
}:
{
  flake.homeConfigurations.mini = inputs.home-manager.lib.homeManagerConfiguration {
    modules = [
      inputs.self.modules.homeManager.miniHome
    ];
  };

  flake.modules.homeManager.miniHome =
    { pkgs, config, ... }:
    {
      inherit pkgs;

      homeDirectory = "/home/${config.preferences.username}";

      nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

      imports = [
        inputs.self.modules.homeManager.shell
      ];

      programs.home-manager.enable = true;
      home.stateVersion = "26.05";
    };
}
