{
  flake.modules.nixos.podman = { pkgs, ... }: {
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

    virtualisation.podman = {
      # dockerSocket.enable = true;
      # dockerCompat = true;
    };

    virtualisation.oci-containers.backend = "podman";

    environment.systemPackages = with pkgs; [ docker-compose podman-compose ];
  };
}
