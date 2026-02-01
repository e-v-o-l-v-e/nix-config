{pkgs, ...}: {
  flake.homeModules.fish = { config, ... }: {

      programs.fish = {
        enable = true;

        generateCompletions = true;

        shellAbbrs = {
          # shell
          ls = "lsd";
          ll = "lsd -l";
          rm = "trash put";
          man = "batman";
          ks = "kitten ssh";

          # editing
          n = "nvim";
          v = "nvim";
          nv = "nvim";
          sv = "sudo -e";

          # git
          g = "git";
          gs = "git status -s";
          gss = "git status";
          pl = "git pull";
          ph = "git push";
          sw = "git switch";
          gm = "git merge";
          br = "git branch";
          gcm = "git commit -m \"";
          grb = "git rebase";

          # nix
          nr = "nix run nixpkgs#";
          ns = "nix shell nixpkgs#";

          # docker
          dc = "docker compose";
        };

        binds = {
          "ctrl-r".command = "history-pager";
          "ctrl-r".mode = "insert";
        };

        shellInit = ''
          set -g fish_greeting ""
          fish_add_path -a /home/${config.users.users.name}/.local/bin
        '';

        interactiveShellInit = ''
          fish_vi_key_bindings
          # zellij -l welcome
          # if test "$TERM" = "xterm-kitty" -a -z "$ZELLIJ"
          #   exec zellij --layout welcome
          # end
        '';

        functions = {
          "ssh" = {
            argumentNames = [ "arguments" ];
            body = ''
              set -lx TERM xterm-256color
              command ssh $arguments
            '';
          };
        };
      };
    };
}
