{
  inputs,
  lib,
  config,
  ...
}:
let
  secrets = inputs.secrets;
  common.sopsFile = "${secrets}/common.yaml";

  sshkeydir = "${config.home.homeDirectory}/.ssh/keys";
in
{
  flake.modules.nixos.sops = {

    imports = [
      inputs.sops-nix.nixosModules.sops
    ];

    sops = {
      enable = true;
      defaultSopsFile = common.sopsFile;
      validateSopsFiles = true;

      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
  };

  flake.modules.homeManager.sops = {

    imports = [
      inputs.sops-nix.homeManagerModules.sops
    ];

    sops = {
      age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      defaultSopsFile = common.sopsFile;
      validateSopsFiles = true;

      secrets = {
        "private_keys/github" = {
          path = "${sshkeydir}/github";
        };
        "private_keys/git_unistra" = {
          path = "${sshkeydir}/git_unistra";
        };
        "ssh-key/private" = {
          path = "${sshkeydir}/waylander";
          sopsFile = "${secrets}/waylander.yaml";
        };
        "ssh-key/public" = {
          path = "${sshkeydir}/waylander.pub";
          sopsFile = "${secrets}/waylander.yaml";
        };
      };
    };
  };
}
