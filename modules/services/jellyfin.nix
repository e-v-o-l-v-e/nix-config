{
  flake.modules.nixos.jellyfin =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.server;
      dataDir = "${cfg.configPath}/jellyfin";
      fqdn = cfg.domain;

      ports.jellyfin = 8096;
      ports.vue = 8888;
    in
    {
      services.jellyfin = {
        inherit dataDir;
        user = cfg.serverUserName;
        group = cfg.serverGroupName;
      };

      # VAAPI hardware transcoding for Intel i3-7100T
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
          "${cfg.dataPath}/media"
        ];
      };

      virtualisation.oci-containers.containers = lib.mkIf config.services.jellyfin.enable {
        jellyfin_vue = {
          autoStart = true;
          serviceName = "docker-vue";
          pull = "always";
          image = "ghcr.io/jellyfin/jellyfin-vue:unstable";
          ports = [ "${toString ports.vue}:8080" ];
          environment = {
            DEFAULT_SERVERS = "https://jellyfin.${fqdn}";
          };
          volumes =
            let
              nginxConf = pkgs.writeTextFile {
                name = "vue-nginx.conf";
                text = ''
                  server {
                      listen 8080;
                      root /usr/share/nginx/html;
                      location / {
                          try_files $uri $uri/ /index.html;
                      }
                  }
                '';
              };
            in
            [ "${nginxConf}:/etc/nginx/conf.d/default.conf" ];
        };
      };

      services.caddy.virtualHosts = lib.mkIf config.services.jellyfin.enable {
        "jellyfin.${fqdn}".extraConfig = ''
          import cfdns
          reverse_proxy http://localhost:${toString ports.jellyfin}
        '';
        "vue.${fqdn}".extraConfig = ''
          import cfdns
          reverse_proxy http://localhost:${toString ports.vue}
        '';
      };
    };
}
