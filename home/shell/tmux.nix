{ pkgs, ... }:
{
  programs.tmux = {
    enable = false;
    shortcut = "a";
    keyMode = "emacs";
    shell = "${pkgs.fish}/bin/fish";
  };
}
