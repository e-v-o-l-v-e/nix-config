{ config,...}: let
  cfg = config.server;
in {
  virtualisation.docker = {
    enableOnBoot = true;

    rootless = {
      enable = true;
      setSocketVariable = true;
    };

    daemon.settings = { 
      # data-root = cfg.ssdPath + "docker/";
      live-restore = true; 
    };
  };

  virtualisation.oci-containers.backend = "docker";
}
