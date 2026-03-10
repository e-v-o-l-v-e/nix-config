{
  flake.modules.nixos.wayland =
    { pkgs, config, ... }:
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

      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
      };

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      security.polkit.enable = config.programs.niri.enable or config.programs.hyprland.enable;
      services.gnome.gnome-keyring.enable = config.programs.niri.enable;
    };
}
