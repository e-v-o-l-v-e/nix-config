{ pkgs, ... }:
{
  programs.tmux = {
    shortcut = "a";
    keyMode = "emacs";
    shell = "${pkgs.fish}/bin/fish";
  };
}
