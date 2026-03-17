{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.server;
  fqdn = cfg.domain;
  port = 8008;
in {
  config = {
    services.matrix-conduit = {
      settings.global = {
        allow_registration = false;

        server_name = "matrix.${fqdn}";
        address = "0.0.0.0";
        inherit port;

        database_backend = "rocksdb";
      };
    };

    environment.systemPackages = lib.optional config.services.matrix-conduit.enable pkgs.element-web;

    services.caddy.virtualHosts = {
      "element.${fqdn}" = {
        serverAliases = [":8009"];
        extraConfig = ''
          root * ${pkgs.element-web.outPath}
          file_server {
            index index.html
          }
        '';
      };
    };
  };
}
