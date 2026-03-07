_: {
  flake.modules.nixos.plymouth =
    { pkgs, ... }:
    {

      boot = {
        plymouth = {
          enable = true;
          theme = "nixos-bgrt";
          themePackages = with pkgs; [
            plymouth-matrix-theme
            nixos-bgrt-plymouth
            plymouth-proxzima-theme
          ];
        };
        loader.timeout = 0;
        kernelParams = [
          "splash"
          "quiet"
          "loglevel=3"
          "systemd.show_status=auto"
          "udev.log_level=3"
          "rd.udev.log_level=3"
          "vt.global_cursor_default=0"
        ];
        consoleLogLevel = 0;

        initrd.verbose = false;
        initrd.systemd.enable = true;

        loader.grub.gfxmodeEfi = "text";
        loader.grub.gfxpayloadEfi = "text";
        loader.grub.splashImage = null;
      };
    };
}
