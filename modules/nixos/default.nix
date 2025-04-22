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
    ./systemVersion.nix
    ./time.nix
    ./user.nix
    ./wayland.nix
  ];
}
