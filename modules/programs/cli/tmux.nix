_: {
  flake.modules.generic.tmux =
    { pkgs, ... }:
    {
      programs.tmux = {
        enable = true;
        shortcut = "a";
        keyMode = "emacs";
        shell = "${pkgs.fish}/bin/fish";
      };
    };
}
