{
  hostname,
  personal,
  ...
}: {
  networking = {
    networkmanager.enable = true;
    nameservers = ["1.1.1.1" "1.0.0.1"];
    hostName = hostname;
  };

  services.openssh.enable = true;
  services.tailscale.enable = true;

  programs.localsend.enable = personal;

  hardware.bluetooth = {
    enable = personal;
  };
}
