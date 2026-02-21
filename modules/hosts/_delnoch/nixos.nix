{ inputs, ... }:
{

  flake.homeConfigurations = inputs.self.lib.mkNixos {
    hostname = "delnoch";
    stateVersion = "25.05";
  };

  flake.modules.nixos.delnoch =
    { config, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        cli-core
        cli-utils
        cli-personal
        cli-nvim

        gui-common
        gui-personnal
      ];
    };
}
