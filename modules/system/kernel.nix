{ lib, ... }: {
  flake.modules.nixos.kernel =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.linux-firmware ];

      boot = {
        kernelPackages = lib.mkDefault pkgs.linuxPackages_zen; # zen kernel
        # kernelPackages = pkgs.linuxPackages_latest;  # default kernel

        kernelParams = [
          "systemd.mask=systemd-vconsole-setup.service"
          "systemd.mask=dev-tpmrm0.device" # this is to mask that stupid 1.5 mins systemd bug
          "nowatchdog"
        ];

        kernel.sysctl = {
          # fix weird crash
          "net.core.rmem_max" = 7500000;
          "net.core.wmem_max" = 7500000;
        };
      };
    };
}
