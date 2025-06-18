{ pkgs, ... }:
{
  imports = [
    ./fonts.nix
    ./gaming.nix
    ./hardware
    ./laptop.nix
    ./locale.nix
    ./login.nix
    ./network.nix
    ./nix.nix
    ./shell.nix
    ./stylix.nix
    ./user.nix
    ./wayland.nix
  ];

  environment.systemPackages = [
    pkgs.kitty
    pkgs.vim
    pkgs.fish
    pkgs.git
    # pkgs.home-manager
  ];
}
