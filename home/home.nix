{
  config,
  inputs,
  username,
  ...
}:
{
  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    inherit (config) keyboard;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    # nh flake path to use `nh os switch/test` without having to specify path
    NH_FLAKE = "/home/${username}/${config.flakePath}";
    # there is a fish function that automatically export TERM as xterm-256color when using ssh
    TERM = if config.programs.kitty.enable then "xterm-kitty" else "xterm-256color";
  };

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  programs.home-manager.enable = true;

  programs.man.generateCaches = false;
}
