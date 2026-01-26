{pkgs, lib, ...}: {
  imports = [
    ./desktop
    ./hardware
    ./laptop.nix
    ./locale.nix
    ./network.nix
    ./nix.nix
    ./server.nix
    ./services
    ./sops.nix
    ./user.nix
  ];

  environment.systemPackages = with pkgs; [
    bat-extras.batman
    duf
    dust
    fish
    git
    kitty
    lsd
    man
    man-pages
    man-pages-posix
    parted
    vim
  ];
}
