{ username, ...}: {
  imports = [
    ./caddy.nix
    ./jellyfin.nix
    ./opencloud.nix
  ];

  users.groups.server = {
    name = "server";
    members = [
      username
      "jellyfin"
    ];
  };
}
