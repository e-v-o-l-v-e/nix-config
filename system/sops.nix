{ inputs, username, ... }:

let
  # Define each sops file path
  secretsDir = ../secrets;

  common.sopsFile = "${secretsDir}/common.yaml";

  server.sopsFile = "${secretsDir}/server.yaml";

  druss.sopsFile = "${secretsDir}/druss.yaml";
  waylander.sopsFile = "${secretsDir}/waylander.yaml";
  delnoch.sopsFile = "${secretsDir}/delnoch.yaml";

  # Helper function for password secrets
  getPwd = name: file: {
    "${name}" = {
      inherit (file) sopsFile;
      key = "password";
    };
  };

in {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = "${secretsDir}/common.yaml";
    validateSopsFiles = false;

    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets = 
      {
        domain-name = server;
        "airvpn/private_key" = common;
        "airvpn/preSharedKey" = common;
      }
      // getPwd "password-druss" druss
      // getPwd "password-waylander" waylander
      // getPwd "password-delnoch" delnoch;
  };

  users.users.${username}.openssh.authorizedKeys.keys = [
    (builtins.readFile "${secretsDir}/public_keys/github.pub")
    (builtins.readFile "${secretsDir}/public_keys/git_unistra.pub")
  ];
}

