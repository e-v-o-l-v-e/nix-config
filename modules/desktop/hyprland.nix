{ inputs, lib, ... }:
{
  flake.modules.nixos.hyprland =
    { pkgs, ... }:
    {
      imports = [
        inputs.self.modules.nixos.wayland
      ];

      programs.hyprland = {
        withUWSM = true;
        enable = true;
        xwayland.enable = true;
      };

      security.pam.services.hyprlock = { };

      services.greetd.settings.default_session = {
        command = "${lib.getExe pkgs.tuigreet} --time --cmd start-hyprland";
      };
    };

  flake.modules.homeManager.hyprland =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.homeManager; [
        gui-theming
        gui-desktop
      ];

      home.packages = with pkgs; [
        kitty

        hypridle
        hyprland
        hyprland-qtutils
        hyprland-qt-support
        hyprland-protocols
        hyprlock
        hyprpicker
        hyprshade
        hyprsunset

        swaynotificationcenter

        wlogout
      ];

      # manage hyprland settings with home-manager,
      # for now my config is not in nix, i will move it at some point
      wayland.windowManager.hyprland.enable = false;
    };
}
