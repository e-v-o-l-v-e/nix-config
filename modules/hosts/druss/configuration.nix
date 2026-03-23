{ self, ... }:
let
  hostname = "druss";
  system = "x86_64-linux";
  mainUser = "evolve";
  users = [ mainUser ];
in
{
  flake.nixosConfigurations.${hostname} = self.lib.mkNixos {
    inherit hostname system;
    stateVersion = "25.05";
  };

  flake.homeConfigurations = builtins.listToAttrs (
    map (username: {
      name = "${username}@${hostname}";
      value = self.lib.mkHomeManager {
        inherit username hostname system;
        stateVersion = "25.05";
      };
    }) users
  );

  flake.modules.nixos.druss = {
    imports =
      with self.modules.nixos;
      [
        # system
        gpu-amd
        systemd-boot

        # programs
        gaming

        # network
        tailscale
        bluetooth
        printing

        # desktop
        plasma
        sddm
        wayland

        # nix
        sops

        # misc
        plymouth
      ]
      ++ map (user: self.modules.nixos.${user}) users;

    boot.loader.timeout = 0;
  };

  flake.modules.homeManager."evolve@${hostname}" = {
    imports = with self.modules.homeManager; [
      # shell
      cli-core
      cli-utils
      cli-personal
      neovim

      # desktop
      gui-common
      gui-personnal
      gui-desktop
      gui-theming
      fonts

      # programs
      nh
      gamingFull

      # perso
      sops
    ];
  };
}
