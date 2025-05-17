{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    keyMode = "emacs";
    shell = "${pkgs.fish}/bin/fish";
  };
}
