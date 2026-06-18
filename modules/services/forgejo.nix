{
  flake.modules.nixos.forgejo =
    { config, lib, ... }:
    let
      cfg = config.server;
      fqdn = cfg.domain;
      DOMAIN = "git.${fqdn}";
      HTTP_PORT = 4214;
    in
    {
      services.forgejo = {
        stateDir = "${cfg.ssdPath}/forgejo";

        dump.enable = true;
        lfs.enable = true;

        settings = {
          server = {
            inherit DOMAIN HTTP_PORT;
            ROOT_URL = "https://${DOMAIN}";

            DISABLE_SSH = false;
            START_SSH_SERVER = true;
            SSH_PORT = 22;
            SSH_LISTEN_PORT = 4217;
          };

          service.DISABLE_REGISTRATION = true;
          session.COOKIE_SECURE = false;
        };
      };

      systemd.tmpfiles.rules = lib.optionals config.services.forgejo.enable (
        let
          inherit (config.services.forgejo) stateDir user group;
        in
        [
          "d ${stateDir} 1775 ${user} ${group} -"
        ]
      );

      services.caddy.virtualHosts = lib.mkIf config.services.paperless.enable {
        "${DOMAIN}".extraConfig = ''
          import cfdns
          reverse_proxy http://localhost:${toString HTTP_PORT}
        '';
      };
    };
}
