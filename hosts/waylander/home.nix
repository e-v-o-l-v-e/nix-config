# Home Manager configuration for the user
{
  pkgs,
  username,
  inputs,
  self,
  system,
  ...
}: let
  inherit (import ./variables.nix) gitUsername gitEmail;
in {
  home = {
    username = username;
    homeDirectory = "/home/${username}";
  };

  # Define user-specific packages
  home.packages = with pkgs;
    [
      element-desktop
      fishPlugins.tide
      jellyfin-media-player
      libreoffice-qt6-fresh
      libsForQt5.kdeconnect-kde
      localsend
      nextcloud-client
      remmina
      steam
      supersonic
      vesktop

      home-manager

      # Code-related packages
      # jdk
      # jdt-language-server
      # jre
      # lua-language-server
      # vimPlugins.nvim-jdtls
    ]
    ++ [
      inputs.zen-browser.packages."${system}".twilight
      self.packages."${system}".my-neovim
    ];

  programs.git = {
    enable = true;
    userName = gitUsername;
    userEmail = gitEmail;
    extraConfig = {
      push = {autoSetupRemote = true;};
    };
  };

  programs.starship = {
    enable = true;
  };

  # Additional shell configurations
  home.sessionVariables = {
    HISTFILE = "$HOME/.fish_history";
    HISTSIZE = "10000";
  };

  # System-level tools available in the shell
  home.stateVersion = "24.11"; # Adjust this based on your Home Manager version
}
