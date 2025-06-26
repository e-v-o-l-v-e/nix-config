{ config, ... }:
  # this is where the per host configuration happens
  # all options and their default values are set in ./options.nix

  # the username is set globally as the username option's default
  # you can override it per host or change it in ./options.nix to use the same on every machine, current is "evolve"
{
  config = {
    server = {
      enable = true;
      services.jellyfin.enable = true;
      services.radarr.enable = true;
      services.sonarr.enable = true;
    };

    networking = {
      wol.enable = true;
      tailscale.enable = true;
    };

    soft.nvf.enable = true;

    login-manager = null;
    system-version = "25.05";
  };
}
