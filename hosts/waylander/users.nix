# Users - NOTE: Packages defined on this will be on current user only
{
  pkgs,
  username,
  ...
}: let
  inherit (import ./variables.nix) gitUsername;
in {
  users = {
    mutableUsers = true;
    users."${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "evolve";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
        "video"
        "input"
        "audio"
        "kvm"
        "inputs"
        "uinputs"
      ];

      #     # define user packages here
      #     packages = with pkgs; [
      #       element-desktop
      #       fishPlugins.tide
      #       jellyfin-media-player
      #       libreoffice-qt6-fresh
      #       libsForQt5.kdeconnect-kde
      #       localsend
      #       nextcloud-client
      #       remmina
      #       steam
      #       supersonic
      #       vesktop
      #
      #       # code
      #       jdk
      #       jdt-language-server
      #       jre
      #       lua-language-server
      #       vimPlugins.nvim-jdtls
      #     ];
    };

    defaultUserShell = pkgs.fish;
  };

  environment.shells = with pkgs; [fish];
  environment.systemPackages = with pkgs; [lsd fzf];

  programs = {
    fish = {
      enable = true;
      plugins = [pkgs.fishPlugins.tide];
    };
  };
}
