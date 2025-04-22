{...}: {
  imports = [
    ./amd-drivers.nix
    ./boot.nix
    ./flatpak.nix
    ./gaming.nix
    ./keyboard.nix
    ./locale.nix
    ./local-hardware-clock.nix
    ./login.nix
    ./network.nix
    ./nix.nix
    ./systemVersion.nix
    ./time.nix
    ./user.nix
    ./wayland.nix
  ];
}
