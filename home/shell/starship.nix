{ lib, ...}: {
  programs.starship = {
    enable = true;

    settings = lib.mkIf false {
      add_newline = false;
      command_timeout = 1000;

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
