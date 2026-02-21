{ inputs, ... }:
{
  flake.modules.homeManager = {
    gui-common =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          blueman
          cliphist
          kitty
          gnome-keyring
          gparted
          libgnome-keyring
          localsend
          loupe
          pavucontrol
          ueberzugpp
          vlc
          wl-clipboard
          nautilus
          ydotool
        ];
      };

    gui-personnal =
      { pkgs, ... }:
      {
        imports = [
          inputs.self.modules.homeManager.fish
          inputs.self.modules.homeManager.lsd
        ];

        home.packages = with pkgs; [
          element-desktop
          finamp
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
  };
}
