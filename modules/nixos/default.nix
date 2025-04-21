{...}: {
  imports = [
    ./amd-drivers.nix
    ./boot.nix
    ./flatpak.nix
    ./keyboard.nix
    ./locale.nix
    ./local-hardware-clock.nix
    ./login.nix
    ./network.nix
    ./time.nix
    ./user.nix
    ./wayland.nix
  ];
}
