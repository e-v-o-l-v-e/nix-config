{ inputs, ... }:
{
  flake.modules.nixos.net = {
    imports = [
      inputs.self.modules.nixos.avahi
    ];

    networking = {
      networkmanager.enable = true;
      wireless.enable = true;

      nameservers = [
        "1.1.1.1"
        "1.0.0.1"
      ];
    };

    hardware.enableAllFirmware = true;
    hardware.enableRedistributableFirmware = true;
  };
}
