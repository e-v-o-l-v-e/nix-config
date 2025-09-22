{
  config,
  pkgs,
  lib,
  ...
}:
let
  perso = config.personal.enable;
in
{
  config = {
    # boot = lib.mkIf (hostname != "wsl") {
    boot = {
      kernelPackages = pkgs.linuxPackages_zen; # zen Kernel
      # kernelPackages = pkgs.linuxPackages_latest; #linux Kernel

      kernelParams = 
        [
          "systemd.mask=systemd-vconsole-setup.service"
          "systemd.mask=dev-tpmrm0.device" # this is to mask that stupid 1.5 mins systemd bug
          "nowatchdog"
          "modprobe.blacklist=sp5100_tco" # watchdog for AMD
        ]
        ++ lib.optionals perso [
          "splash"
          "quiet"
          "boot.shell_on_fail"
          "rd.systemd.show_status=auto"
          "udev.log_priority=3"
        ];

      # This is for OBS Virtual Cam Support
      kernelModules = [ "v4l2loopback" ];
      extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

      # initrd = {
      #   availableKernelModules = [
      #     "xhci_pci"
      #     "ahci"
      #     "nvme"
      #     "usb_storage"
      #     "usbhid"
      #     "sd_mod"
      #   ];
      #   # verbose = !perso;
      # };
      # consoleLogLevel = 4; # lib.mkIf perso 3;

      kernel.sysctl =  {
        # Needed For Some Steam Games
        "vm.max_map_count" = lib.mkIf config.programs.steam.enable 2147483642;

        # fix weird crash
        "net.core.rmem_max" = 7500000;
        "net.core.wmem_max" = 7500000;
      };

      ## BOOT LOADERS: NOTE USE ONLY 1. either systemd or grub
      # Bootloader SystemD
      # loader.systemd-boot.enable = true;

      loader.efi = {
        #efiSysMountPoint = "/efi"; #this is if you have separate /efi partition
        canTouchEfiVariables = true;
      };

      loader.timeout = lib.mkIf perso 0;

      # Bootloader GRUB
      #loader.grub = {
      #  enable = true;
      #  devices = [ "nodev" ];
      #  efiSupport = true;
      #  gfxmodeBios = "auto";
      #  memtest86.enable = true;
      #  extraGrubInstallArgs = [ "--bootloader-id=waylander" ];
      #  configurationName = "waylander";
      #};

      ## -end of BOOTLOADERS----- ##

      # Make /tmp a tmpfs
      tmp = {
        useTmpfs = false;
        tmpfsSize = "30%";
      };

      # Appimage Support
      binfmt.registrations.appimage = {
        wrapInterpreterInShell = false;
        interpreter = "${pkgs.appimage-run}/bin/appimage-run";
        recognitionType = "magic";
        offset = 0;
        mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
        magicOrExtension = ''\x7fELF....AI\x02'';
      };
    };
  };
}
