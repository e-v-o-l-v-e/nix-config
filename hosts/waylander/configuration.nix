{
  pkgs,
  lib,
  HM,
  config,
  ...
}:
# this is where the per host configuration happens
# all options and their default values are set in ./options.nix
# the username is set globally as the username option's default
# you can override it per host or change it in ./options.nix to use the same on every machine, current is "evolve"
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
      gui.theme = "light";

      # specialisation."light".configuration = {
      #   gui.theme = "light";
      #   environment.etc."specialisation".text = "light";
      # };

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
        # programs.nvf.settings.vim.theme = lib.mkForce {
        #   enable = true;
        #   # name = "tokyonight";
        #   # style = "night";
        # };

        programs.kitty.nixConfig.enable = true;

        programs.zellij.enable = false;

        programs.zen-browser.enable = true;

        wayland.windowManager.hyprland.enable = false; # manage hyprland settings with home-manager

        # home-manager version at the time of first install, do not change
        home.stateVersion = "25.05";
      }
      else {
        #=#=#=# SYSTEM #=#=#=#
        laptop.enable = true;

        gpu = "amd";

        # nixos version at the time of first install, do not change
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

        # boot.loader.grub.theme = "${pkgs.kdePackages.breeze-grub}/grub/themes/breeze";
        # boot.loader.timeout = lib.mkForce 2;
        # boot.loader.grub.timeoutStyle = "menu";

        # boot.plymouth = {
        #   enable = true;
        #   theme = "nixos-bgrt";
        #   themePackages = with pkgs; [
        #     plymouth-matrix-theme
        #     nixos-bgrt-plymouth
        #     plymouth-proxzima-theme
        #   ];
        # };

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
          initrd.kernelModules = [ "amdgpu" ];

          loader.grub.gfxmodeEfi = "text";
          loader.grub.gfxpayloadEfi = "text";
          loader.grub.splashImage = null;
        };
      }
    )
  ];
}
