{
  hostname,
  config,
  lib,
  ...
}:let
  cfg = config.personal;
in {
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    nameservers = lib.optionals (hostname != "wsl") [
      "1.1.1.1"
      "1.0.0.1"
    ];
  };

  services.openssh.enable = true;
  services.tailscale.enable = true;

  programs.localsend.enable = cfg.enable;
  hardware.bluetooth.enable = cfg.enable;
}
