{ config, pkgs, lib, ... }:

{
  # Allow unfree packages (for some fonts and proprietary software)
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Fonts and Theming
    adw-gtk3  # ADW GTK theme (alternative to adw-gtk-theme-git)
    darkly
    kdePackages.plasma-integration
    libsForQt5.plasma-integration
    space-grotesk  # Space Grotesk font

    # gabarito
    (callPackage ({ fetchFromGitHub, stdenvNoCC }: stdenvNoCC.mkDerivation {
      name = "gabarito-font";
      src = fetchFromGitHub {
        owner = "anewtypeofinterference";
        repo = "Gabarito";
        rev = "main";
        sha256 = "0000000000000000000000000000000000000000000000000000";
      };
      installPhase = "mkdir -p $out/share/fonts/truetype && cp -r *.ttf $out/share/fonts/truetype/";
    }) {})
    jetbrains-mono  # JetBrains Mono font
    material-symbols  # Material Symbols
    (callPackage ({ fetchFromGitHub, stdenvNoCC }: stdenvNoCC.mkDerivation {
      name = "readex-pro-font";
      src = fetchFromGitHub {
        owner = "ThomasJockin";
        repo = "readexpro";
        rev = "main";
        sha256 = "0000000000000000000000000000000000000000000000000000";
      };
      installPhase = "mkdir -p $out/share/fonts/truetype && cp -r *.ttf $out/share/fonts/truetype/";
    }) {})
    rubik  # Rubik font
    noto-fonts-emoji  # Twemoji alternative

    # Hyprland and Wayland ecosystem
    hypridle
    hyprcursor
    hyprland
    (callPackage ({ fetchFromGitHub, cmake, pkg-config, ... }: stdenv.mkDerivation {
      name = "hyprland-qtutils";
      src = fetchFromGitHub {
        owner = "hyprwm";
        repo = "hyprland-qtutils";
        rev = "main";
        sha256 = "0000000000000000000000000000000000000000000000000000";
      };
      nativeBuildInputs = [ cmake pkg-config ];
      buildInputs = [ qt6.qtbase ];
    }) {})
    xdg-desktop-portal-hyprland
    wl-clipboard

    # KDE components
    bluedevil
    plasma5.plasma-nm
    plasma5.polkit-kde-agent

    # Python tools
    python311Packages.uv  # Python package installer
    libportal  # libportal library

    # Qt6 components
    qt6.qt5compat
    qt6.qtimageformats  # Includes AVIF support
    qt6.qtmultimedia
    qt6.qtpositioning
    qt6.qtquicktimeline
    qt6.qtsensors
    qt6.qtvirtualkeyboard
    syntax-highlighting

    # Utilities
    ydotool
    fuzzel
    (callPackage ({ fetchFromGitHub, rustPlatform, ... }: rustPlatform.buildRustPackage {
      name = "quickshell";
      src = fetchFromGitHub {
        owner = "quickshell";
        repo = "quickshell";
        rev = "main";
        sha256 = "0000000000000000000000000000000000000000000000000000";
      };
      cargoSha256 = "0000000000000000000000000000000000000000000000000000";
    }) {})
    translate-shell

    # Cursor themes and icons
    bibata-cursors  # Bibata cursor theme
    (callPackage ({ fetchFromGitHub, stdenvNoCC }: stdenvNoCC.mkDerivation {
      name = "oneui4-icons";
      src = fetchFromGitHub {
        owner = "end-4";
        repo = "OneUI4-Icons";
        rev = "main";
        sha256 = "0000000000000000000000000000000000000000000000000000";
      };
      installPhase = "mkdir -p $out/share/icons && cp -r OneUI* $out/share/icons/";
    }) {})

    # MicroTeX alternative (using basic LaTeX)
    texlive.combined.scheme-small
  ];

  # Additional configuration for some packages
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  # Font configuration
  fonts.fontconfig.enable = true;

  # XDG portal configuration
  xdg = {
    enable = true;
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-kde
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
}
