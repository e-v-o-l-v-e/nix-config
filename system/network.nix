{
  hostname,
  config,
  lib,
  ...
}:
let
  perso = config.personal.enable;
  cfg = config.networking;
in
{
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    interfaces = lib.mkIf cfg.wol.enable {
      eth0.wakeOnLan.enable = true;
    };
  };

  services.openssh.enable = true;
  services.tailscale.enable = cfg.tailscale.enable;

  programs.localsend.enable = perso;
  hardware.bluetooth.enable = perso;
}
