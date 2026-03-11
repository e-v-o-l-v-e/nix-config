{ inputs, ... }:
{
  flake.modules.homeManager = {
    gui-common =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          blueman
          brightnessctl
          cliphist
          gnome-keyring
          gparted
          kitty
          libgnome-keyring
          localsend
          loupe
          nautilus
          pavucontrol
          ueberzugpp
          vlc
          wl-clipboard
          ydotool
        ];
      };

    gui-personnal =
      { pkgs, ... }:
      {
        imports = [
          inputs.self.modules.homeManager.zen-browser
        ];

        home.packages = with pkgs; [
          element-desktop
          jellyfin-desktop
          kdePackages.kdeconnect-kde
          libreoffice-qt6-fresh
          opencloud-desktop
          opencloud-desktop-shell-integration-dolphin
          thunderbird
          vesktop
          zathura
        ];
      };

    gui-desktop =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          grim
          rofi
          slurp
          swappy
          swaynotificationcenter
          swww
          waybar
          waypaper
          wlogout
        ];
      };

    gui-theming =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          adwaita-icon-theme
          bibata-cursors
          dconf
          gsettings-qt
          gtk-engine-murrine
          gtk3
          gtk4
          libadwaita
        ];
      };
  };
}
