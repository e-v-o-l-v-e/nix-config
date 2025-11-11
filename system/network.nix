{
  hostname,
  config,
  username,
  lib,
  ...
}: let
  perso = config.personal.enable;
  secretsDir = ../secrets;
in {
  config = {
    networking = {
      hostName = hostname;
      networkmanager.enable = true;

      nameservers = [
        "1.1.1.1"
        "1.0.0.1"
      ];

      firewall.allowedTCPPorts = lib.optionals config.server.enable config.server.openPorts;
    };

    services.openssh.enable = true;

    users.users.${username}.openssh.authorizedKeys.keys = [
      (builtins.readFile "${secretsDir}/public_keys/github.pub")
      (builtins.readFile "${secretsDir}/public_keys/git_unistra.pub")
      (builtins.readFile "${secretsDir}/public_keys/waylander.pub")
    ];

    programs.localsend.enable = perso;
    hardware.bluetooth = {};
  };
}
