{ inputs, username, ... }:
let
  server.sopsFile = ../secrets/server.yaml;
  common.sopsFile = ../secrets/common.yaml;
in 
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ../secrets/common.yaml;
    validateSopsFiles = false;

    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets = {
      domain-name = server;
      "airvpn/private_key" = common;
      "airvpn/preSharedKey" = common;
    };
  };

  users.users.${username}.openssh.authorizedKeys.keys = [
    (builtins.readFile ../secrets/public_keys/github.pub)
    (builtins.readFile ../secrets/public_keys/git_unistra.pub)
  ];
}
