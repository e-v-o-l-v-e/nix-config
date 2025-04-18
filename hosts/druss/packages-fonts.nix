# 💫 https://github.com/JaKooLit 💫 #
# Packages and Fonts config including the "programs" options
{
  self,
  pkgs,
  inputs,
  system,
  ...
}: let
  python-packages = pkgs.python3.withPackages (
    ps:
      with ps; [
        requests
        pyquery # needed for hyprland-dots Weather script
      ]
  );
in {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    (with pkgs; [
      # System Packages
      ffmpeg
      glib #for gsettings to work
      glow
      gsettings-qt
      libappindicator
      libnotify
      nixd
      openssl #required by Rainbow borders
      pciutils
      ripgrep
      starship
      tree
      vim
      wget
      xdg-user-dirs
      xdg-utils
      zoxide

      fastfetch
      (mpv.override {scripts = [mpvScripts.mpris];}) # with tray
      #ranger

      # Hyprland Stuff
      #(ags.overrideAttrs (oldAttrs: { inherit (oldAttrs) pname; version = "1.8.2"; }))
      ags # desktop overview
      btop
      brightnessctl # for brightness control
      cava
      cliphist
      loupe
      gnome-system-monitor
      grim
      gtk-engine-murrine #for gtk themes
      hypridle
      hyprpicker
      hyprshade
      imagemagick
      inxi
      jq
      kitty
      libsForQt5.qtstyleplugin-kvantum #kvantum
      networkmanagerapplet
      nwg-displays
      nwg-look
      nvtopPackages.full
      pamixer
      pavucontrol
      playerctl
      polkit_gnome
      pyprland
      libsForQt5.qt5ct
      kdePackages.qt6ct
      kdePackages.qtwayland
      kdePackages.qtstyleplugin-kvantum #kvantum
      rofi-wayland
      slurp
      swappy
      swaynotificationcenter
      swww
      unzip
      wallust
      wl-clipboard
      wlogout
      xarchiver
      yad
      yt-dlp

      waybar # if wanted experimental next line
      #(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
    ])
    ++ [
      python-packages
      inputs.zen-browser.packages."${system}".default
      self.packages."${system}".my-neovim
    ];

  # FONTS
  fonts.packages = with pkgs; [
    noto-fonts
    fira-code
    noto-fonts-cjk-sans
    jetbrains-mono
    font-awesome
    terminus_font
    victor-mono
    (nerdfonts.override {fonts = ["JetBrainsMono"];}) # stable banch
    (nerdfonts.override {fonts = ["FantasqueSansMono"];}) # stable banch
    (nerdfonts.override {fonts = ["DaddyTimeMono"];}) # stable banch

    #nerd-fonts.jetbrains-mono # unstable
    #nerd-fonts.fira-code # unstable
    #nerd-fonts.fantasque-sans-mono #unstable
  ];

  programs = {
    hyprland = {
      enable = true;
      #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland; #hyprland-git
      #portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland; #xdph-git

      portalPackage = pkgs.xdg-desktop-portal-hyprland; # xdph none git
      xwayland.enable = true;
    };

    waybar.enable = true;
    hyprlock.enable = true;
    git.enable = true;
    nm-applet.indicator = true;
    # neovim.enable = true;

    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
      exo
      mousepad
      thunar-archive-plugin
      thunar-volman
      tumbler
    ];

    virt-manager.enable = false;

    #steam = {
    #  enable = true;
    #  gamescopeSession.enable = true;
    #  remotePlay.openFirewall = true;
    #  dedicatedServer.openFirewall = true;
    #};

    xwayland.enable = true;

    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # Extra Portal Configuration
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

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          "/dev/input/event1"
          "/dev/input/event4"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (deflocalkeys-linux
            conf 171
          )
          (defsrc
             caps esc a s d f j k l ;
            conf
          )
          (defvar
             tap-time 149
             hold-time 150
             long-tap-time 200
             long-hold-time 200
          )

          (defalias
             escctrl (tap-hold 200 200 esc lctl)
             a (tap-hold $long-tap-time $long-hold-time a lalt)
             s (tap-hold $tap-time $long-hold-time s lmet)
             d (tap-hold $tap-time $hold-time d lsft)
             f (tap-hold $tap-time $hold-time f lctl)
             j (tap-hold $tap-time $hold-time j rctl)
             k (tap-hold $tap-time $hold-time k rsft)
             l (tap-hold $tap-time $hold-time l rmet)
             ; (tap-hold $long-tap-time $long-hold-time ; ralt)
             base (layer-switch base)
             game (layer-switch game)
             cec (layer-switch cec)
          )

          (deflayer base
             @escctrl caps @a @s @d @f @j @k @l @;
             @game
          )
          (deflayer game
             @escctrl caps a s d f @j @k @l @;
             @cec
          )
          (deflayermap cec
             caps @escctrl
             esc caps
             conf @base
          )
        '';
      };
    };
  };
}
