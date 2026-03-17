{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [openrgb-with-all-plugins];
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };
}
