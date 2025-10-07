{
  pkgs,
  lib,
  HM,
  config,
  ...
}:
# this is where the per host configuration happens
# most options are set in the relevant files, those needed by HM and Nixos are in custom/option.nix
# the username is set globally in flake.nix
{
  config = lib.mkMerge [
    {
      flakePath = "nix-config";

      #=#=#=# HOME #=#=#=#
      personal.enable = true;

      sops-nix.enable = true;

      keyboard = {
        layout = "gb";
        variant = "extd";
      };

      # gui / theming #
      gui.enable = true;

      gui.hyprland.enable = true;

      programs.waybar.enable = true;

      gaming.enable = true;
      gaming.full = false;
    }
    (
      if HM
      then {
        #=#=#=# HOME #=#=#=#
        # Apps #
        programs.nvf.enable = true;
        programs.nvf.maxConfig = true;

        # programs.kitty.enable = config.gui.enable;
        programs.kitty.nixConfig.enable = false;

        programs.zellij.enable = false; # better / easier tmux

        programs.zen-browser.enable = true;

        wayland.windowManager.hyprland.enable = false; # manage hyprland settings with home-manager

        gui.matugen.enable = true;

        # home-manager version at the time of first install, do not change when upgrading
        home.stateVersion = "25.05";
      }
      else {
        #=#=#=# SYSTEM #=#=#=#
        laptop.enable = true;

        gpu = "amd";

        # nixos version at the time of nixos install, do not change when upgrading
        system.stateVersion = "25.11";

        # Desktop #
        login-manager = "greetd";

        programs.hyprland.enable = config.gui.hyprland.enable;

        services.desktopManager.plasma6.enable = false;

        # Apps #
        services.kanata.enable = true;

        # Network #
        hardware.bluetooth.enable = true;
        services.tailscale.enable = true;

        ## SERVER TESTING ##
        server.enable = false;
        server.domain = "imp-network.com";
        # services.caddy.enable = true;

        ## BOOTING ##
        # boot.loader.grub.theme = "${pkgs.kdePackages.breeze-grub}/grub/themes/breeze";
        # boot.loader.timeout = lib.mkForce 2;
        # boot.loader.grub.timeoutStyle = "menu";

        boot = lib.mkForce {
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
          initrd.kernelModules = ["amdgpu"];

          loader.grub.gfxmodeEfi = "text";
          loader.grub.gfxpayloadEfi = "text";
          loader.grub.splashImage = null;
        };

        services.printing.enable = true;

        services.avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };
      }
    )
  ];
}
