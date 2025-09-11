{ config, lib, ... }: let
  cfg = config.server;
  fqdn = cfg.domain;
  port = 8008;
in {
  services.matrix-conduit = {
    settings.global = {
      allow_registration = true;
      registration_token = config.sops.secrets.matrix-registration-token.path;

      server_name = "matrix.${fqdn}";
      address = "0.0.0.0";
      inherit port;

      database_backend = "rocksdb";

      media = {
        path = cfg.dataPath + "/matrix/media";
      };
    };
  };
}
