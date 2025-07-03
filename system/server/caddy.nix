{config, ...}:
{
  services.caddy = {
    virtualHosts = {
      "test.cloud.imp-network.com" = {
        # serverAliases = [ "www.hydra.example.com" ];
        extraConfig = ''
          reverse_proxy http://localhost:9200
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
