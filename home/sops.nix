{ inputs, username, ... }:
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
    defaultSopsFile = ../secrets/common.yaml;
    validateSopsFiles = false;
  };

  secrets = {
    "private_keys/github" = {
      path = "/home/${username}/.ssh/github";
    };
  };
}
