{ inputs, ... }:
let
  username = "evolve";
in
{
  flake.modules.nixos.${username} = {

    users.users.${username} = {
      name = username;

      home = "/home/${username}";
      isNormalUser = true;

      openssh.authorizedKeys.keyFiles = [
        "${inputs.secrets}/public_keys/github.pub"
        "${inputs.secrets}/public_keys/git_unistra.pub"
        "${inputs.secrets}/public_keys/waylander.pub"
      ];

      extraGroups = [
        "audio" "docker" "input" "inputs" "key" "kvm" 
        "libvirtd" "lp" "networkmanager" "scanner" 
        "uinputs" "users" "video" "wheel"
      ];
    };
  };
}
