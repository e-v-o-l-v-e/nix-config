{
  username,
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.server;
  dataDir = "${cfg.configPath}/jellyfin";
  fqdn = config.server.domain;

  ports.jellyfin = 8096;
  ports.vue = 8888;
in {
  services.jellyfin = {
    inherit dataDir;
    user = cfg.serverUserName;
    group = cfg.serverGroupName;
  };

  environment.systemPackages = lib.mkIf config.services.jellyfin.enable [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];

  # transcoding
  hardware.graphics = lib.mkIf config.services.jellyfin.enable {
    inherit (config.services.jellyfin) enable;
    extraPackages = with pkgs; [
      intel-media-driver
      libva-vdpau-driver
      intel-compute-runtime-legacy1
      vpl-gpu-rt
    ];

    extraPackages32 = with pkgs.driversi686Linux; [
      intel-media-driver
      libva-vdpau-driver
    ];
  };

  systemd.services = lib.mkIf config.services.jellyfin.enable {
    jellyfin.serviceConfig.ReadWritePaths = [
      (cfg.dataPath + "/media") 
      "/data/media/tv"
      "/data/media/music"
      "/data/media/music2"
      "/data/media"
      "/data"
      "/data/media/movies"
    ];
  };

  # virtualisation.oci-containers.containers = lib.mkIf config.services.jellyfin.enable {
  #   jellyfin_vue = {
  #     autoStart = true;
  #     serviceName = "vue";
  #     pull = "always";
  #     image = "ghcr.io/jellyfin/jellyfin-vue:unstable";
  #     ports = [ "${toString ports.vue}:80" ];
  #   };
  # };

  services.caddy.virtualHosts = lib.mkIf config.services.jellyfin.enable {
    "jellyfin.${fqdn}" = {
      extraConfig = ''
        import cfdns
        reverse_proxy http://localhost:${toString ports.jellyfin}
      '';
    };
    # "vue.${fqdn}" = {
    #   extraConfig = ''
    #     import cfdns
    #     reverse_proxy http://localhost:${toString ports.vue}
    #   '';
    # };
  };
}
