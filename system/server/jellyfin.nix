{ config, ...}:let
  confDir = config.server.configPath;
in {
  services.jellyfin = {
    inherit (config.server.services.jellyfin) enable;
    group = "server";
    configDir = "${confDir}/jellyfin";
  };
}
