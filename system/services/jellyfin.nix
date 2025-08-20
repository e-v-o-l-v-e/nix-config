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

  # # pretty sure this is unnecessary, but it's on the wiki :shrug:
  # environment.systemPackages = lib.mkIf config.services.jellyfin.enable [
  #   pkgs.jellyfin
  #   pkgs.jellyfin-web
  #   pkgs.jellyfin-ffmpeg
  # ];

  # transcoding with vaapi for i3-7100T
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
    ];
  };

  virtualisation.oci-containers.containers = lib.mkIf config.services.jellyfin.enable {
    jellyfin_vue = {
      autoStart = true;
      serviceName = "vue";

      pull = "always";
      image = "ghcr.io/jellyfin/jellyfin-vue:unstable";

      ports = ["${toString ports.vue}:8080"];

      environment = {
        DEFAULT_SERVERS = "https://jellyfin.${fqdn}";
      };

      volumes = let
        # we override the default config file, changing the port from 80 to 8080 as we run docker in rootless mode
        nginxConf = pkgs.writeTextFile {
          name = "vue-nginx.conf";
          text = ''
            server {
                listen 8080;
                root /usr/share/nginx/html;
                location / {
                    # First attempt to serve request as file, then as directory, then fall back to redirecting to index.html
                    # This is needed for history mode in Vue router: https://router.vuejs.org/guide/essentials/history-mode.html#nginx
                    try_files $uri $uri/ /index.html;
                }
            }'';
        };
      in [
        "${nginxConf}:/etc/nginx/conf.d/default.conf"
      ];
    };
  };

  services.caddy.virtualHosts = lib.mkIf config.services.jellyfin.enable {
    "jellyfin.${fqdn}" = {
      extraConfig = ''
        import cfdns
        reverse_proxy http://localhost:${toString ports.jellyfin}
      '';
    };
    "vue.${fqdn}" = {
      extraConfig = ''
        import cfdns
        reverse_proxy http://localhost:${toString ports.vue}
      '';
    };
  };
}
