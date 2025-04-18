{...}: {
  programs.fish = {
    enable = true;

    shellAbbrs = {
      # shell
      ls = "lsd";
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
    };
  };

  programs.zoxide = {
    enable = true;

    enableFishIntegration = true;
    options = [
      "--cmd cd"
    ];
  };

  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;

      aws = {symbol = "  ";};
      buf = {symbol = " ";};
      c = {symbol = " ";};
      dart = {symbol = " ";};
      directory = {read_only = " ";};
      docker_context = {symbol = " ";};
      elixir = {symbol = " ";};
      elm = {symbol = " ";};
      git_branch = {symbol = " ";};
      golang = {symbol = " ";};
      haskell = {symbol = " ";};
      hg_branch = {symbol = " ";};
      java = {symbol = " ";};
      julia = {symbol = " ";};
      lua = {symbol = " ";};
      memory_usage = {symbol = "󰘚 ";};
      nim = {symbol = " ";};
      nix_shell = {symbol = "  ";};
      nodejs = {symbol = " ";};
      package = {symbol = "󰏗 ";};
      python = {symbol = " ";};
      rlang = {symbol = " ";};
      ruby = {symbol = " ";};
      rust = {symbol = " ";};
      scala = {symbol = " ";};
    };
  };
}
