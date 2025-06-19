{ pkgs, ... }:
{
  imports = [
    # ./fonts.nix
    ./desktop
    ./hardware
    ./laptop.nix
    ./locale.nix
    ./network.nix
    ./nix.nix
    ./user.nix
  ];

  environment.systemPackages = [
    pkgs.kitty
    pkgs.vim
    pkgs.fish
    pkgs.git
  ];
}
