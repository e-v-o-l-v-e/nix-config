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
      # "*" = {
      #   # serverAliases = [ "www.hydra.example.com" ];
      #   extraConfig = ''
      #     tls {
      #       dns cloudflare {env.CLOUDFLARE_API_TOKEN}
      #     }
      #   '';
      # };
      "test.${fqdn}" = {
        extraConfig = ''
          respond "DRUUUUUS"

          import cfdns
        '';
      };
    };

    extraConfig = ''
      (cfdns) {
        tls {
          dns cloudflare {env.CLOUDFLARE_API_TOKEN}
          resolvers 1.1.1.1
        }
      }
    '';
  };

  systemd.services = lib.mkIf config.services.caddy.enable {
    caddy.serviceConfig.EnvironmentFile =  config.sops.secrets.caddy-env.path;
    caddy.serviceConfig.AmbientCapabilities = "CAP_NET_BIND_SERVICE";
  };
}
