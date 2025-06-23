{ username, config, lib, ...}: let
  cfg = config.server;
in {
  imports = [
    ./caddy.nix
    ./jellyfin.nix
    ./opencloud.nix
  ];

  users.groups.server = lib.mkIf cfg.enable {
    name = "server";
    gid = 2000;
    members = [
      username
      "jellyfin"
    ];
  };

  users.users.${username}.linger = cfg.enable;
}
