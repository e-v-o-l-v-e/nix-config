{config, pkgs, inputs, lib, ...}: let
  fqdn = config.server.domain;
in {
  nixpkgs.overlays = [ (import ../../custom/overlays/caddy-cloudflare.nix inputs) ];

  services.caddy = {
    package = pkgs.caddy-cloudflare;

    globalConfig = ''
      acme_dns cloudflare {env.CLOUDFLARE_API_TOKEN}
    '';

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

  systemd.services = lib.mkIf config.services.caddy.enable {
    caddy.serviceConfig.EnvironmentFile =  config.sops.secrets.caddy-env.path;
    caddy.serviceConfig.AmbientCapabilities = "CAP_NET_BIND_SERVICE";
  };
}
