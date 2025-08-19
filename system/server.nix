{
  username,
  config,
  lib,
  ...
}: let
  cfg = config.server;
in {
  config = {
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

    openPorts = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      default = [80 443];
      description = "List of ports to open";
    };

    staticAdress = lib.mkEnableOption "Enable static IPv4 address";

    vpn.enable = lib.mkEnableOption "Enable AirVPN over WireGuard";

    vpn.forwardedPort = lib.mkOption {
      type = types.port;
      default = null;
      example = 123456;
      description = "Port used for port forwading when using vpn, or without (not recommended)";
    };
  };
}
