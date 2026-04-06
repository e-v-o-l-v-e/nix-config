{
  flake.modules.nixos.docker = {
    virtualisation.docker = {
      enableOnBoot = true;

      # rootless = {
      #   enable = true;
      #   setSocketVariable = true;
      # };

      daemon.settings = {
        live-restore = true;
      };
    };

    virtualisation.oci-containers.backend = "docker";
  };
}
