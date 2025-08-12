{ lib, config, ...}: let
  cfg = config.server;
  dataDir = "${cfg.configPath}/jellyfin";
  fqdn = config.server.domain;
in {
  services.jellyfin = {
    inherit dataDir;
    user = "jellyfin";
    group = "media";
  };

  virtualisation.oci-containers.containers = lib.mkIf config.services.jellyfin.enable {
    jellyfin_vue = {
      autoStart = true;
      serviceName = "vue";
      pull = "always";
      image = "ghcr.io/jellyfin/jellyfin-vue:unstable";
      ports = [ "8888:80" ];
    };
  };


  services.caddy.virtualHosts = lib.mkIf config.services.jellyfin.enable {
    "jellyfin.${fqdn}" = {
      extraConfig = ''
        reverse_proxy http://localhost:8096
      '';
    };
    "vue.${fqdn}" = {
      extraConfig = ''
        reverse_proxy http://localhost:8888
      '';
    };
  };
}
