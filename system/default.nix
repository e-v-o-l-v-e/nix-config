{pkgs, ...}: {
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

  environment.systemPackages = [
    pkgs.duf
    pkgs.dust
    pkgs.fish
    pkgs.git
    pkgs.kitty
    pkgs.lsd
    pkgs.vim
  ];
}
