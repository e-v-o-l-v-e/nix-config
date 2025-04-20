{
  lib,
  hostname,
  ...
}: {
  imports =
    [
      ./network.nix
    ]
    ++ (lib.mkIf hostname == "waylander") [
      ./amd-drivers.nix
      ./local-hardware-clock.nix
      ./vm-guest-services.nix
    ];
}
