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
    pkgs.man
    pkgs.bat-extras.batman
    pkgs.man-pages
    pkgs.man-pages-posix
    pkgs.duf
    pkgs.dust
    pkgs.fish
    pkgs.git
    pkgs.kitty
    pkgs.lsd
    pkgs.vim
  ];
}
