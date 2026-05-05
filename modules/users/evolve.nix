{ self, ... }:
let
  username = "evolve";
in
{
  flake.modules.nixos.${username} =
    { pkgs, ... }:
    {

      users.users.${username} = {
        name = username;

        home = "/home/${username}";
        isNormalUser = true;

        shell = pkgs.fish;

        openssh.authorizedKeys.keyFiles = [
          "${self}/secrets/public_keys/github.pub"
          "${self}/secrets/public_keys/git_unistra.pub"
          "${self}/secrets/public_keys/waylander.pub"
        ];

        # TODO modularize
        extraGroups = [
          "audio" "docker" "input" "inputs" "key" "kvm"
          "libvirtd" "lp" "networkmanager" "scanner"
          "uinputs" "users" "video" "wheel" "render"
        ];
      };

      programs.fish.enable = true;
    };
}
