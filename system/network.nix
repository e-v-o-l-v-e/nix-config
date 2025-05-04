{
  hostname,
  personal,
  lib,
  ...
}:
{
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

  programs.localsend.enable = personal;
  hardware.bluetooth.enable = personal;
}
