{ config, lib, ... }: let
  cfg = config.server;
  fqdn = cfg.domain;
  port = 8008;
in {
  services.matrix-conduit = {
    settings.global = {
      address = "0.0.0.0";
      inherit port;
      database_backend = "rocksdb";
    };
  };
}
