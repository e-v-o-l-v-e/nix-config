{ inputs, ... }:
let
  hostname = "waylander";
  system = "x86_64-linux";
  mainUser = "evolve";
  users = [ mainUser ];
in
{
  flake.nixosConfigurations.${hostname} = inputs.self.lib.mkNixos {
    inherit hostname system;
    stateVersion = "25.11";
  };

  flake.homeConfigurations = builtins.listToAttrs (
    map (username: {
      name = "${username}@${hostname}";
      value = inputs.self.lib.mkHomeManager {
        inherit username hostname system;
        stateVersion = "26.05";
      };
    }) users
  );

  flake.modules.nixos.waylander = {
    imports =
      with inputs.self.modules.nixos;
      [
        # system
        gpu-amd

        # programs
        gaming
        kanata

        # network
        bluetooth
        printing
        tailscale

        # desktop
        hyprland

        # nix
        sops

        # misc
        plymouth
      ]
      ++ map (user: inputs.self.modules.nixos.${user}) users;

    boot.loader.timeout = 0;

    system.stateVersion = "25.11";
  };

  flake.modules.homeManager."evolve@${hostname}" = {
    imports = with inputs.self.modules.homeManager; [
      # shell
      cli-core
      cli-utils
      cli-personal
      neovim

      # desktop
      gui-common
      gui-personnal
      hyprland

      # programs
      nh
      steam
    ];
  };
}
