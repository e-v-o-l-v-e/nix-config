{
  hostname,
  config,
  username,
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
    };

    services.openssh.enable = true;

    users.users.${username}.openssh.authorizedKeys.keys = [
      (builtins.readFile "${secretsDir}/public_keys/github.pub")
      (builtins.readFile "${secretsDir}/public_keys/git_unistra.pub")
    ];

    programs.localsend.enable = perso;

    # defined in host/${hostname}/configuration.nix
    services.tailscale = {};
    hardware.bluetooth = {};
  };

  services.openssh.enable = true;

  programs.ssh.knownHosts = {
    waylander = {
      extraHostNames = [ "100.104.213.127" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmY8HqI6skQ+wLYUEtfCVyceFUH/VD7pRzIjCTLOxYo evolve@waylander";
    };
  };

  users.users.${username}.openssh.authorizedKeys.keys = [
    (builtins.readFile "${secretsDir}/public_keys/github.pub")
    (builtins.readFile "${secretsDir}/public_keys/git_unistra.pub")
  ];

  programs.localsend.enable = perso;

  # defined in host/${hostname}/configuration.nix
  services.tailscale = {};
  hardware.bluetooth = {};
}
