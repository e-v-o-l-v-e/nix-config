{ username, config, lib, pkgs, ... }:
let
  cfg = config.server;
in
{
  imports = [
    ./caddy.nix
    ./jellyfin.nix
    ./opencloud.nix
    ./radarr.nix
  ];

  users.groups.server = lib.mkIf cfg.enable {
    name = cfg.groupName;
    gid = cfg.groupId;
    members = [
      username
      "jellyfin"
    ];
  };

  users.users.${username}.linger = cfg.enable;

  # systemd.tmpfiles = lib.mkIf cfg.enable {
  #   rules = lib.mkMerge [
  #     (lib.mkBefore [
  #       "d ${cfg.configPath} 770 evolve server - -"
  #       "d ${cfg.dataPath} 770 evolve server - -"
  #       "d ${cfg.dataPath}/config 770 evolve server - -"
  #     ])
  #     (lib.mkAfter [
  #       "Z ${cfg.configPath} 770 server - -"
  #       "Z ${cfg.dataPath}/media 770 - server -"
  #       "Z ${cfg.dataPath}/config 770 - server -"
  #     ])
  #     # [ "C /home/evolve - - - - /usr/bin/setfacl -m g:server:x /home/evolve" ]
  #   ];
  # };

  # systemd.services.set-evolve-acl = lib.mkIf cfg.enable {
  #   description = "Set ACL on /home/evolve for group server";
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = [ "${pkgs.setfacl}/bin/setfact" "-m" "g:server:x" "/home/evolve" ];
  #   };
  # };

}
