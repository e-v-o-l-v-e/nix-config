{
  config,
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf config.illogical-impulse.enable {
    # Allow unfree packages (for some fonts and proprietary software)
    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
      # Fonts and Theming
      adw-gtk3 # ADW GTK theme (alternative to adw-gtk-theme-git)
      darkly
      kdePackages.plasma-integration
      barlow # Space Grotesk font

      jetbrains-mono # JetBrains Mono font
      material-symbols # Material Symbols

      rubik # Rubik font
      noto-fonts-emoji # Twemoji alternative

      # Hyprland and Wayland ecosystem
      hypridle
      hyprcursor
      hyprland
      hyprland-qtutils

      xdg-desktop-portal-hyprland
      wl-clipboard

      # KDE components
      kdePackages.bluedevil
      kdePackages.plasma-nm
      kdePackages.polkit-kde-agent-1

      # Python tools
      python311Packages.uv # Python package installer
      libportal # libportal library

      # Qt6 components
      qt6.qt5compat
      qt6.qtimageformats # Includes AVIF support
      qt6.qtmultimedia
      qt6.qtpositioning
      qt6.qtquicktimeline
      qt6.qtsensors
      qt6.qtvirtualkeyboard
      kdePackages.syntax-highlighting

      # Utilities
      ydotool
      fuzzel
      quickshell
      translate-shell

      # Cursor themes and icons
      bibata-cursors # Bibata cursor theme

      # MicroTeX alternative (using basic LaTeX)
      texlive.combined.scheme-small
    ];

    # Additional configuration for some packages
    gtk = {
      enable = true;
      # theme = {
      #   name = "adw-gtk3-dark";
      #   package = pkgs.adw-gtk3;
      # };
    };

    qt = {
      enable = true;
      # platformTheme = "gnome";
      # style = {
      #   name = "adwaita-dark";
      #   package = pkgs.adwaita-qt;
      # };
    };

    # Font configuration
    fonts.fontconfig.enable = true;

    # XDG portal configuration
    xdg = {
      enable = true;
      portal = {
        enable = true;
        config.common.default = "*";

        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          kdePackages.xdg-desktop-portal-kde
          xdg-desktop-portal-hyprland
        ];
      };
    };

    # Environment variables
    home.sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      GDK_BACKEND = "wayland";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
    };
  };

  options = {
    illogical-impulse.enable = lib.mkEnableOption "enable packages required by end-4's dotfiles";
  };
}
