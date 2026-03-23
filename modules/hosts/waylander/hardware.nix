{
  flake.modules.nixos.waylander =
    { pkgs, ... }:
    {
      hardware.cpu.amd.updateMicrocode = true;

      boot.kernelModules = [ "kvm-amd" ];
      boot.kernelPackages = pkgs.linuxPackages_latest;

      boot.initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "usb_storage"
        "sd_mod"
      ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/d7469df8-e49b-458d-bb9c-6751a51dbd79";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/DCC9-E6E9";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      fileSystems."/home" = {
        device = "/dev/disk/by-uuid/78775fe4-8070-40a6-b041-48c7db92b0ac";
        fsType = "ext4";
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/b084febb-84f7-41fb-96a5-8c6b75715ea2"; }
      ];
    };
}
