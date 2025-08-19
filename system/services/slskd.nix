{
  config,
  lib,
  ...
}: let
  cfg = config.server;

  fqdn = cfg.domain;
  webuiPort = 5030;

  slskdDir = "${cfg.dataPath}/torrents/slskd";
in {
  services.slskd = {
    group = cfg.serverGroupName;
    user = cfg.serverUserName;

    environmentFile = config.sops.secrets."slskd.env".path;

    settings = {
      web.port = webuiPort;
      # web.https.disabled = true;

      soulseek.listen_port = cfg.vpn.forwardedPort;
      soulseek.description = "YOLOOO";

      directories.downloads = slskdDir + "/downloads";
      directories.incomplete = slskdDir + "/incomplete";

      shares.directories = [
        "${cfg.dataPath}/media/music"
        # "${cfg.dataPath}/media/music-import"
      ];

      flags.force_share_scan = false;
      flags.no_version_check = true;
    };

    domain = null;
  };

  services.caddy.virtualHosts = lib.mkIf config.services.slskd.enable {
    "slskd.${fqdn}".extraConfig = ''
      reverse_proxy http://localhost:${toString webuiPort}
      import cfdns
    '';
  };

  systemd.services.slskd.serviceConfig.UMask = "0002";
}
