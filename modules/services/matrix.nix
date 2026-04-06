{
  flake.modules.nixos.matrix =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      fqdn = config.server.domain;
      port = 8008;
    in
    {
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
          serverAliases = [ ":8009" ];
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
