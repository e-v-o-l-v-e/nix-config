{ inputs, username, ... }:
let
  sshkeydir = "/home/${username}/.ssh/keys";
in 
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
    defaultSopsFile = ../secrets/common.yaml;
    validateSopsFiles = false;

    secrets = {
      "private_keys/github" = {
        path = "${sshkeydir}/github";
      };
      "private_keys/git_unistra" = {
        path = "${sshkeydir}/git_unistra";
      };
    };
  };
}
