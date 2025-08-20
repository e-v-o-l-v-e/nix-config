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
  services.silverbullet = {
    user = username;
    group = "users";

    inherit listenPort spaceDir;

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

  services.caddy.virtualHosts = lib.mkIf config.services.silverbullet.enable {
    "silverbullet.${fqdn}" = {
      extraConfig = ''
        import cfdns
        reverse_proxy http://localhost:${toString listenPort}
      '';
    };
  };

  # systemd.tmpfiles.rules = lib.mkIf config.services.silverbullet.enable [
  #   "d ${cfg.ssdPath}/silverbullet 0775 silverbullet users -"
  #   "d ${spaceDir} 0775 silverbullet users -"
  #   "Z ${cfg.configPath} 0775 silverbullet users -"
  # ];
}
