{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.server;
  fqdn = cfg.domain;
  port = 8008;

  element-override = pkgs.element-web.override {
    conf = {
      "default_server_config" = {
        "m.homeserver" = {
          "base_url" = "https://matrix.${fqdn}";
          "server_name" = "imp-network.com";
        };
      };
    };
  };
in {
  services.matrix-conduit = {
    settings.global = {
      allow_registration = false;

      server_name = "matrix.${fqdn}";
      address = "0.0.0.0";
      inherit port;

      database_backend = "rocksdb";
    };
  };

  environment.systemPackages = lib.optionals config.services.matrix-conduit.enable [
    element-override
  ];

  services.caddy.virtualHosts = {
    "element.${fqdn}" = {
      serverAliases = [":8009"];
      extraConfig = ''
        root * ${element-override.outPath}
      file_server {
        index index.html
      }
      '';
    };
  };
}
