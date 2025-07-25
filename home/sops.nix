{ inputs, username, lib, config, ... }:
let
  cfg = config.sops-nix;
  sshkeydir = "/home/${username}/.ssh/keys";
in 
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  config.sops = lib.mkIf cfg.enable {
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
