_:
{
  programs.fish = {
    enable = true;

    shellAbbrs = {
      # shell
      ls = "lsd";
      rm = "trash";

      "bh" = {
        position = "anywhere";
        expansion = "| bat -phelp";
      };

      # editing
      n = "nvim";
      v = "nvim";
      nv = "nvim";
      sv = "sudo -e";

      # git
      g = "git";
      gs = "git status -s";
      gss = "git status";
      sw = "git switch";
      br = "git branch";
      cm = "git commit -m \"";
      rb = "git rebase";
      ph = "git push";
      pl = "git pull";
      me = "git merge";

      # nix
      nr = "nix run nixpkgs#";
      ns = "nix shell nixpkgs#";

      # hypr
      nl0 = "hyprshade off";
      nl = "hyprshade toggle bluefilter";
      nl2 = "hyprshade toggle blue-light-filter";

      # docker
      dc = "docker compose";
    };

    shellInit = ''
      set -g fish_greeting ""
    '';

    interactiveShellInit = ''
      fish_vi_key_bindings
    '';

    functions."ssh" = {
      argumentNames = [ "argv" ];
      body = ''
        set -lx TERM xterm-256color
        command ssh $argv
      '';
    };
  };
}
