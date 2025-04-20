{
  lib,
  hostname,
  ...
}: {
  imports = [
    ./locale.nix
    ./network.nix
    ./time.nix
    ./amd-drivers.nix
    ./vm-guest-services.nix
  ];
}
