{
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.sops-nix;

  # Define each sops file path
  secretsDir = ../secrets;

  common.sopsFile = "${secretsDir}/common.yaml";
  server.sopsFile = "${secretsDir}/server.yaml";

  # specific host
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

  sops = lib.mkIf cfg.enable {
    defaultSopsFile = common.sopsFile;
    validateSopsFiles = false;

    age = {
      sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets =
      {
        caddy-env = lib.mkIf config.services.caddy.enable {
          inherit (server) sopsFile;
          owner = "caddy";
        };

        # services
        silverbullet-env = server;
        "slskd.env" = server;
        kavita-token = server;

        # network
        "wg-airvpn.conf" = server;
        cloudflared-cred = server;

        "airvpn/private_key" = common;
        "airvpn/preSharedKey" = common;
      }
      // getPwd "password-druss" druss
      // getPwd "password-waylander" waylander
      // getPwd "password-delnoch" delnoch
      // getPwd "password-test" common;
  };
}
