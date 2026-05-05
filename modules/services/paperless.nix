{ self, ... }:
{
  # REQUIRE MODULE [ server ]
  flake.modules.nixos.paperless =
    {
      config,
      lib,
      ...
    }:
    let
      cfg = config.server;
    in
    {
      nixpkgs.overlays = [
        (_: prev: {
          paperless-ngx = prev.paperless-ngx.overrideAttrs { doCheck = false; dontUsePytestCheck = true; };
        })
      ];

      services.paperless = {
        passwordFile = config.sops.secrets.paperless-password-file.path;
        dataDir = "${cfg.ssdPath}/paperless";
        domain = "paperless.${cfg.domain}";
        address = "0.0.0.0";

        configureTika = true;

        settings = {
          PAPERLESS_OCR_LANGUAGE = "fra+eng";
          PAPERLESS_DATE_PARSER_LANGUAGES = "fr";
          PAPERLESS_FILENAME_FORMAT = "{{ created_year }}/{{ correspondent }}/{{ title }}";
        };

        environmentFile = config.sops.secrets.paperless-env.path;
      };

      sops.secrets.paperless-password-file.sopsFile = "${self}/secrets/server.yaml";
      sops.secrets.paperless-env.sopsFile = "${self}/secrets/server.yaml";

      systemd.tmpfiles.rules =
        let
          inherit (config.services.paperless) dataDir user;
          group = cfg.serverGroupName;
        in
        [
          "d ${dataDir} 1775 ${user} ${group} -"
        ];

      services.caddy.virtualHosts = lib.mkIf config.services.paperless.enable {
        "${config.services.paperless.domain}".extraConfig = ''
          import cfdns
          reverse_proxy http://localhost:${toString config.services.paperless.port} {
              header_down Referrer-Policy "strict-origin-when-cross-origin"
          }
        '';
      };
    };
}
