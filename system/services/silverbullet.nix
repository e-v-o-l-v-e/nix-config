{
  lib,
  pkgs,
  username,
  config,
  ...
}: let
  cfg = config.server;

  listenPort = 3333;
  spaceDir = cfg.ssdPath + "/silverbullet/space";
  fqdn = cfg.domain;
in {
  config = {
    services.silverbullet = {
      user = username;
      group = "users";

      inherit listenPort spaceDir;

      listenAddress = "0.0.0.0";

      envFile = config.sops.secrets.silverbullet-env.path;

      package = pkgs.silverbullet.overrideAttrs (oldAttrs: rec {
        version = "0.10.4";
        src = pkgs.fetchurl {
          url = "https://github.com/silverbulletmd/silverbullet/releases/download/${version}/silverbullet.js";
          hash = "sha256-ko1zXfvn0rVY+lp9zTZ71BL41h7AOazooBVeqELP3Ps=";
        };
      });
    };

    systemd.services = lib.mkIf config.services.silverbullet.enable {
      silverbullet.serviceConfig = {
        Environment = "DENO_DIR=/var/cache/silverbullet/deno";
        CacheDirectory = "silverbullet";
      };
    };

    services.caddy.virtualHosts = lib.mkIf (config.services.silverbullet.enable || cfg.docker.silverbullet.enable) {
      "silverbullet.${fqdn}" = {
        extraConfig = ''
          import cfdns
          reverse_proxy http://localhost:${toString listenPort}
        '';
      };
    };

    virtualisation.oci-containers.containers = lib.mkIf cfg.docker.silverbullet.enable {
      silverbullet-docker = {
        autoStart = true;
        serviceName = "docker-silverbullet";

        pull = "newer";
        image = "ghcr.io/silverbulletmd/silverbullet:v2";

        ports = ["${toString listenPort}:3000"];

        volumes = [
          "${cfg.ssdPath}/silverbullet/space:/space"
        ];

        # environment = {
        #   already the default with docker
        #   SB_HOSTNAME = "0.0.0.0";
        # };

        environmentFiles = [
          config.sops.secrets.silverbullet-env.path
        ];
      };
    };
  };

  options = {
    server.docker.silverbullet.enable = lib.mkEnableOption "Enable silverbullet docker container (package is kinda broken rn)";
  };
}
