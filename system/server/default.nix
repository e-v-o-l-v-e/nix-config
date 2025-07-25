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
  imports = [
    ./caddy.nix
    ./jellyfin.nix
    ./jellyseerr.nix
    ./lidarr.nix
    ./local-content-share.nix
    ./network.nix
    ./opencloud.nix
    ./prowlarr.nix
    ./radarr.nix
    ./readarr.nix
    ./silverbullet.nix
    ./sonarr.nix
  ];

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
  };
}
