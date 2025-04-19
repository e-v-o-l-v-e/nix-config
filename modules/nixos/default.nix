{
  lib,
  hostname,
  ...
}: {
  imports = (lib.mkIf hostname == "waylander") [
    ./amd-drivers.nix
    ./local-hardware-clock.nix
    ./vm-guest-services.nix
  ];
}
