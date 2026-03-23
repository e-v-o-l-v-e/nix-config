{
  flake.modules.nixos.druss = {

    networking.interfaces.enp6s0.wakeOnLan.enable = true;

    boot.kernelModules = [
      "kvm-amd"
      "i2c-dev" # rgb stuff
    ];

    hardware.i2c.enable = true;

    boot.initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "uas"
      "usbhid"
      "sd_mod"
    ];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/bcfe7139-6644-45f1-b0e1-753a2b4e8114";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/7787-C2CD";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    fileSystems."/mnt/ssd_ext4_2t" = {
      device = "/dev/disk/by-uuid/15ae7cc8-bd6a-40ce-9a4c-8056027aa6e9";
      fsType = "ext4";
    };

    fileSystems."/mnt/ssd_ext4_1t" = {
      device = "/dev/disk/by-uuid/a32bb54a-7bae-4e95-b4ec-18c74826e145";
      fsType = "ext4";
    };
  };
}
