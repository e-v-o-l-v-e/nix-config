{ self, ... }:
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
          wf-recorder
          wl-clipboard
          ydotool
        ];
      };

    gui-personnal =
      { pkgs, ... }:
      {
        imports = [
          self.modules.homeManager.zen-browser
          self.modules.homeManager.mime
        ];

        home.packages = with pkgs; [
          element-desktop
          jellyfin-desktop
          kdePackages.kdeconnect-kde
          libreoffice-qt6-fresh
          opencloud-desktop
          opencloud-desktop-shell-integration-dolphin
          stow
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
          networkmanager_dmenu
          rofi
          slurp
          swappy
          awww
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
