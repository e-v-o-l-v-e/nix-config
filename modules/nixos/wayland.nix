{
  pkgs,
  lib,
  DE,
  ...
}: {
  config = lib.mkMerge [
    (lib.mkIf (builtins.elem "hyprland" DE) {
      programs.hyprland = {
        enable = true;
        portalPackage = pkgs.xdg-desktop-portal-hyprland;
        xwayland.enable = true;
      };
    })

    (lib.mkIf (builtins.elem "plasma" DE) {
      services.xserver.enable = true;
      services.desktopManager.plasma6.enable = true;
    })

    {
      xdg.portal = {
        enable = true;
        wlr.enable = false;
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
        ];
        configPackages = [
          pkgs.xdg-desktop-portal-gtk
          pkgs.xdg-desktop-portal
        ];
      };

      environment.sessionVariables.NIXOS_OZONE_WL = "1";

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
    }
  ];
}
