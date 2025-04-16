{...}: {
  imports = [
    ../shared/common.nix
    ./hardware.nix
    ./users.nix
    ./home.nix
    ./packages-fonts.nix
    ./kanata.nix
    ../../modules/hardware/default.nix
  ];
}
