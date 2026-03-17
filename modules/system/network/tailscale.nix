{ inputs, ... }:
{
  flake.modules.nixos.tailscale = {
    imports = [
      inputs.self.modules.nixos.avahi
    ];

    services.tailscale.enable = true;
  };
}
