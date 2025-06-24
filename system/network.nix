{
  hostname,
  config,
  ...
}:let
  cfg = config.personal;
in {
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    interfaces.eth0.wakeOnLan.enable = true;
  };

  services.openssh.enable = true;
  services.tailscale.enable = true;

  programs.localsend.enable = cfg.enable;
  hardware.bluetooth.enable = cfg.enable;
}
