{
  config,
  username,
  lib,
  ...
}:
{
  config = {
    programs.home-manager.enable = true;

    home = {
      inherit username;
      homeDirectory = "/home/${username}";
    };

    home.sessionVariables = {
      EDITOR = "nvim";
      # nh flake path to use `nh os switch/test` without having to specify path
      NH_FLAKE = "/home/${username}/${config.flakePath}";
      # there is a fish function that automatically export TERM as xterm-256color when using ssh
      TERM = if config.programs.kitty.enable then "xterm-kitty" else "xterm-256color";
    };
  };

  options = {
    homeManagerOnly = lib.mkEnableOption "For standalone home-manager";

    flakePath = lib.mkOption {
      type = lib.types.str;
      default = "nix-config";
      description = "path to the flake directory from /home/{username}";
    };
  };
}
