{
  flake.modules.nixos.slskd =
    { config, lib, ... }:
    let
      cfg = config.server;
      fqdn = cfg.domain;
      webuiPort = 5030;
      slskdDir = "${cfg.dataPath}/media/music-unmapped";
    in
    {
      services.slskd = {
        group = cfg.serverGroupName;
        user = cfg.serverUserName;
        environmentFile = config.sops.secrets."slskd.env".path;
        domain = null;
        settings = {
          web.port = webuiPort;
          soulseek.listen_port = cfg.vpn.forwardedPort;
          soulseek.description = "YOLOOO";
          directories.downloads = slskdDir;
          directories.incomplete = null;
          shares.directories = [
            "${cfg.dataPath}/media/music"
          ];
          flags.force_share_scan = false;
          flags.no_version_check = true;
        };
      };

      services.caddy.virtualHosts = lib.mkIf config.services.slskd.enable {
        "slskd.${fqdn}".extraConfig = ''
          reverse_proxy http://localhost:${toString webuiPort}
          import cfdns
        '';
      };

      systemd.services.slskd.serviceConfig.UMask = "0002";
    };
}
