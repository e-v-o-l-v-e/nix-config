{
  config,
  pkgs,
  lib,
  gpu,
  hostname,
  personal,
  useAppImage,
  ...
}:
{
  boot = lib.mkIf (hostname != "wsl") {
    kernelPackages = pkgs.linuxPackages_zen; # zen Kernel
    #kernelPackages = pkgs.linuxPackages_latest; #linux Kernel

    kernelParams =
      [
        "systemd.mask=systemd-vconsole-setup.service"
        "systemd.mask=dev-tpmrm0.device" # this is to mask that stupid 1.5 mins systemd bug
        "nowatchdog"
        "modprobe.blacklist=sp5100_tco" # watchdog for AMD
      ]
      ++ lib.optionals personal [
        "splash"
        "quiet"
        "boot.shell_on_fail"
        "rd.systemd.show_status=auto"
        "udev.log_priority=3"
      ];

    # This is for OBS Virtual Cam Support
    #kernelModules = [ "v4l2loopback" ];
    #  extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      kernelModules = lib.optional (gpu == "amd") "amdgpu";
      verbose = !personal;
    };
    consoleLogLevel = lib.mkIf personal 3;

    # Needed For Some Steam Games
    kernel.sysctl = lib.mkIf config.programs.steam.enable {
      "vm.max_map_count" = 2147483642;
    };

    ## BOOT LOADERS: NOTE USE ONLY 1. either systemd or grub
    # Bootloader SystemD
    loader.systemd-boot.enable = true;

    loader.efi = {
      #efiSysMountPoint = "/efi"; #this is if you have separate /efi partition
      canTouchEfiVariables = true;
    };

    loader.timeout = 3;

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
    binfmt.registrations.appimage = lib.mkIf useAppImage {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };

    plymouth = {
      enable = hostname == "druss";
      theme = "flame";
      # theme = "rings";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [
            "rings"
            "liquid"
            "blockchain"
            "flame"
          ];
        })
        # (adi1090x-plymouth-themes.override {selected_themes = ["rings" "liquid" "blockchain" "colorfull-loop" "cyanide" "flame" "green-blocks" "hud-space"];})
        nixos-bgrt-plymouth
      ];
    };
  };
}
