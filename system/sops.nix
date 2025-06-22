{ inputs, username, config, lib, ... }:
let
  cfg = config.soft.sops-nix;
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  # config = lib.mkIf cfg.enable {
    sops = {
      defaultSopsFile = ../secrets/common.yaml;
      validateSopsFiles = false;

      age = {
        sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
        keyFile = "/var/lib/sops-nix/key.txt";
        generateKey = true;
      };

      secrets = {
      };
    };

    users.users.${username}.openssh.authorizedKeys.keys = [
      (builtins.readFile ../secrets/public_keys/github.pub)
      (builtins.readFile ../secrets/public_keys/git_unistra.pub)
    ];
  # };
}
