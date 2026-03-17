{
  lib,
  config,
  ...
}: let
  cfg = config.server;
  fqdn = cfg.domain;

  Port = 5000;
  dataDir = cfg.configPath + "/kavita";
in {
  services.kavita = {
    user = cfg.serverUserName;

    settings = {
      inherit dataDir Port;
    };

    tokenKeyFile = config.sops.secrets.kavita-token.path;
  };

  services.caddy.virtualHosts = lib.mkIf config.services.kavita.enable {
    "kavita.${fqdn}" = {
      extraConfig = ''
        import cfdns
        reverse_proxy http://localhost:${toString Port}
      '';
    };
  };
}
