{
  hostConfig,
  config,
  ...
}:
let
  inherit (hostConfig) username;
in
{
  programs.home-manager.enable = true;

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
  };

  home.keyboard = {
    layout = "gb";
    variant = "extd";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    # nh flake path to use `nh os switch/test` without having to specify path
    NH_FLAKE = "home/${hostConfig.username}/${hostConfig.flakePath}";
    # there is a fish function that automatically export TERM as xterm-256color when using ssh
    TERM = if config.programs.kitty.enable then "xterm-kitty" else "xterm-256color";
  };

  home.stateVersion = hostConfig.system-version or "25.5";
}
