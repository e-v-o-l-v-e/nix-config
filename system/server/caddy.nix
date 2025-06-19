{config, ...}: let
  cfg = config.server;
in {
  services.caddy = {
    inherit (cfg) enable;
    virtualHosts = {
      "test.cloud.imp-network.com" = {
        # serverAliases = [ "www.hydra.example.com" ];
        extraConfig = ''
          reverse_proxy https://localhost:8100
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
