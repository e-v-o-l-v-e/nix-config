{config, ...}: let
  cfg = config.server.services.caddy;
in {
  services.caddy = {
    inherit (cfg) enable;
    virtualHosts = {
      "test.cloud.imp-network.com" = {
        # serverAliases = [ "www.hydra.example.com" ];
        extraConfig = ''
          reverse_proxy http://localhost:8100
        '';
      };
      "test.imp-network.com" = {
        extraConfig = ''
          respond "DRUUUUUS"
        '';
      };
    };
  };
}
