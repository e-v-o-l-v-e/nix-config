{config, ...}: let
  fqdn = config.server.domain;
in {
  services.caddy = {
    virtualHosts = {
      "test.cloud.${fqdn}" = {
        # serverAliases = [ "www.hydra.example.com" ];
        extraConfig = ''
          reverse_proxy http://localhost:9200
        '';
      };
      "test.${fqdn}" = {
        extraConfig = ''
          respond "DRUUUUUS"
        '';
      };
    };
  };
}
