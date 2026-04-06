
{ config, lib , ... }: let
  cfg = config.server;
  fqdn = cfg.domain;
  port = 2283;
in {
  services.hedgedoc = {
    settings = {
        inherit port;
        host = "0.0.0.0";
        domain = fqdn;
    }
  };

  services.caddy.virtualHosts = lib.mkIf config.services.hedgedoc.enable {
    "hedgedoc.${fqdn}" = {
      extraConfig = ''
        import cfdns
        reverse_proxy http://localhost:${toString port}
      '';
    };
    "hedgedoc.ts.${fqdn}" = {
      extraConfig = ''
        import cfdns
        reverse_proxy http://localhost:${toString port}
      '';
    };
  };
}
