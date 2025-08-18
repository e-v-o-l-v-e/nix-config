{
  username,
  config,
  lib,
  ...
}:
let
  cfg = config.server;
in
{
  config = {
    users.groups = lib.mkIf cfg.enable {
      "${cfg.mediaGroupName}" = {
        name = cfg.mediaGroupName;
        gid = cfg.mediaGroupId;
        members = [
          username
          "jellyfin"
          "radarr"
          "sonarr"
          "lidarr"
        ];
      };

      server = {
        name = "server";
        gid = 1001;
        members = [
          username
          "jellyfin"
          "radarr"
          "sonarr"
          "lidarr"
          "opencloud"
        ];
      };
    };

    users.users.${username}.linger = cfg.enable;
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

    mediaGroupName = mkOption {
      type = types.str;
      default = "media";
      description = "Nom du groupe auquel appartiendront les services media (arr stack, jellyfin etc)";
    };

    mediaGroupId = mkOption {
      type = types.int;
      default = 2000;
      description = "Id du groupe auquel appartiendront les services media (arr stack, jellyfin etc)";
    };

    openPorts = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      default = [ 80 443 ];
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
