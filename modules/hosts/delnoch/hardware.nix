{
  flake.modules.nixos.delnoch =
    { config, lib, pkgs, ... }:
    {
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      boot.kernelModules = [ "kvm-intel" ];
      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "uas"
        "sd_mod"
      ];

      # Realtek r8168 - fixes network instability under load
      boot.extraModulePackages = [ config.boot.kernelPackages.r8168 ];
      boot.blacklistedKernelModules = [ "r8169" ];
      boot.kernelParams = [ "pcie_aspm=off" ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/a76a5006-37ef-4055-94a1-2da71ced4ea8";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/9D52-0F98";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      services.fstrim.enable = false;
      swapDevices = [ ];

      # Disable Realtek offloads on enp2s0 to prevent network drops
      systemd.services.disable-enp2s0-offloads = {
        description = "Disable Realtek offloads on enp2s0";
        wantedBy = [ "multi-user.target" ];
        after = [ "network-pre.target" ];
        wants = [ "network-pre.target" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.ethtool}/bin/ethtool -K enp2s0 rx off tx off tso off gso off gro off";
          RemainAfterExit = true;
        };
      };
    };
}
