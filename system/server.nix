{
  username,
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.server;
in {
  config = {
    environment.systemPackages = lib.optionals cfg.enable [
      pkgs.iotop 
    ];

    users.groups = lib.mkIf cfg.enable {
      ${cfg.serverGroupName} = {
        # name = cfg.serverGroupName;
        gid = cfg.serverGroupId;

        members = [
          username
        ];
      };
    };

    users.users = lib.mkIf cfg.enable {
      ${cfg.serverUserName} = {
        name = cfg.serverUserName;
        uid = cfg.serverUserId;

        isSystemUser = true;

        group = cfg.serverGroupName;

        linger = cfg.enable;
      };
    };

    networking.firewall = lib.mkIf (cfg.allowedSubnets != [] && cfg.openPortsLocal != []) {
      # concat all string in a list, separated with "\n"
      extraCommands = lib.concatStringsSep "\n" (
        # merge several list in only one
        lib.concatLists (
          # map a fonction to a list
          map (
            subnet:
              map (
                port: "iptables -A INPUT -p tcp -s ${subnet} --dport ${toString port} -j ACCEPT"
              )
              cfg.openPortsLocal
          )
          cfg.allowedSubnets
        )
      );
    };
  };

  options.server = with lib; {
    enable = mkEnableOption "Enable server fonctionnalities";

    configPath = mkOption {
      type = types.str;
      default = "/services-config";
      description = "path to the server's services config dir";
    };

    dataPath = mkOption {
      type = types.str;
      default = "/data";
      description = "path to the data dir";
    };

    ssdPath = mkOption {
      type = types.str;
      default = "/ssd";
      description = "path to the ssd data dir, for small frequently accessed files";
    };

    domain = mkOption {
      type = types.str;
      default = "example.com";
      description = "main FQDN";
    };

    domainSecondary = mkOption {
      type = types.str;
      default = "example.com";
      description = "secondary FQDN";
    };

    openPorts = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      default = [80 443];
      description = "List of ports to open";
    };

    allowedSubnets = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "List of subnet allowed to connect to {openPortsLocal}";
    };

    openPortsLocal = mkOption {
      type = types.listOf types.port;
      default = [
        8096 # jellyfin
        5055 # jellyseerr
      ];
      description = "List of ports accessible by {allowedSubnets}";
    };

    vpn.enable = lib.mkEnableOption "Enable AirVPN over WireGuard";

    vpn.forwardedPort = lib.mkOption {
      type = types.nullOr types.port;
      default = null;
      example = 123456;
      description = "Port used for port forwading when using vpn, or without (not recommended)";
    };

    serverGroupName = mkOption {
      type = types.str;
      default = "server";
      description = "Nom du groupe auquel appartiendront les services media (arr stack, jellyfin etc)";
    };

    serverGroupId = mkOption {
      type = types.int;
      default = 555;
      description = "Id du groupe auquel appartiendront les services media (arr stack, jellyfin etc)";
    };

    serverUserName = mkOption {
      type = types.str;
      default = "server";
      description = "Nom du user auquel appartiendront les services media (arr stack, jellyfin etc)";
    };

    serverUserId = mkOption {
      type = types.int;
      default = 555;
      description = "Id du user auquel appartiendront les services media (arr stack, jellyfin etc)";
    };
  };
}
