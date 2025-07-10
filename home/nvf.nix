# list of nvf module options, examples, instruction etc :
# https://notashelf.github.io/nvf/options.html
{
  config,
  username,
  lib,
  ...
}:
let
  inherit (config.programs.nvf) maxConfig;
  light = (config.gui.theme == "light");
in
{
  config.programs.nvf = {
    settings.vim = {
      viAlias = true;
      vimAlias = false;
      debugMode = {
        enable = false;
        level = 16;
        logFile = "/tmp/nvim.log";
      };

      spellcheck = {
        enable = true;
        languages = [
          "en"
          "fr"
        ];
      };

      undoFile.enable = true;
      searchCase = "smart";
      options = {
        cursorlineopt = "line";
        shiftwidth = 2;
        scrolloff = 10;
      };

      lsp = {
        formatOnSave = false;
        lspkind.enable = false;
        lightbulb.enable = maxConfig;
        lspsaga.enable = false;
        trouble.enable = maxConfig;
        lspSignature.enable = maxConfig;
        otter-nvim.enable = true;
        nvim-docs-view.enable = false;
      };

      diagnostics.config = {
        underline.enable = true;
        virtual_lines.enable = false;
      };

      debugger = {
        nvim-dap = {
          enable = maxConfig;
          ui.enable = true;
          # sources = {
          #   java = "vscode-extensions.vscjava.vscode-java-pack";
          # };
        };
      };

      # This section does not include a comprehensive list of available language modules.
      # To list all available language module options, please visit the nvf manual.
      lsp.enable = true;
      languages = {
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        # Languages.
        nix = {
          enable = true;
          extraDiagnostics.enable = true;
          treesitter.enable = true;
          format.type = "nixfmt";
          lsp = {
            server = "nixd";
            options = {
              nixos.expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.waylander.options";
              # home-manager = "(builtins.getFlake (builtins.toString ./.)).homeConfigurations.waylander.options";

              home-manager.expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.waylander.options.home-manager.users.type.getSubOptions []";
            };
          };
        };
        java.enable = maxConfig;
        csharp.enable = maxConfig;
        python.enable = maxConfig;
        markdown.enable = false; # tmp true;
        yaml.enable = true;
        dart.enable = false;

        lua.enable = maxConfig;
        bash.enable = true;
        clang.enable = true;
        css.enable = maxConfig;
        html.enable = maxConfig;
        sql.enable = true;
        kotlin.enable = false;
        ts.enable = false;
        go.enable = false;
        zig.enable = false;
        typst.enable = false;
        rust = {
          enable = false;
          crates.enable = false;
        };

        # Language modules that are not as common.
        assembly.enable = false;
        astro.enable = false;
        nu.enable = false;
        julia.enable = false;
        vala.enable = false;
        scala.enable = false;
        r.enable = false;
        gleam.enable = false;
        ocaml.enable = false;
        elixir.enable = false;
        haskell.enable = false;
        ruby.enable = false;
        fsharp.enable = false;

        tailwind.enable = false;
        svelte.enable = false;
      };

      visuals = {
        nvim-scrollbar.enable = false;
        nvim-web-devicons.enable = true;
        nvim-cursorline.enable = true;
        cinnamon-nvim.enable = true;
        fidget-nvim.enable = maxConfig;

        highlight-undo.enable = true;
        indent-blankline.enable = true;

        # Fun
        cellular-automaton.enable = false;
      };

      statusline = {
        lualine = {
          enable = true;
          # theme = "iceberg_dark"; # "catppuccin";nvf
        };
      };

      theme = lib.mkForce {
        enable = true;
        # base16-colors = {
        #   inherit (config.lib.stylix.colors)
        #     base00 base01 base02 base03
        #     base04 base05 base06 base07
        #     base08 base09 base0A base0B
        #     base0C base0D base0E base0F;
        # };
      } //
      (if light then {
        name = "catppuccin";
        style = "latte";
      } else {
        name = "tokyonight";
        style = "night";
      });
      # base16-colors = {
      #   inherit (config.lib.stylix.colors) base00;
      #   inherit (config.lib.stylix.colors) base01;
      #   inherit (config.lib.stylix.colors) base02;
      #   inherit (config.lib.stylix.colors) base03;
      #   inherit (config.lib.stylix.colors) base04;
      #   inherit (config.lib.stylix.colors) base05;
      #   inherit (config.lib.stylix.colors) base06;
      #   inherit (config.lib.stylix.colors) base07;
      #   inherit (config.lib.stylix.colors) base08;
      #   inherit (config.lib.stylix.colors) base09;
      #   inherit (config.lib.stylix.colors) base0A;
      #   inherit (config.lib.stylix.colors) base0B;
      #   inherit (config.lib.stylix.colors) base0C;
      #   inherit (config.lib.stylix.colors) base0D;
      #   inherit (config.lib.stylix.colors) base0E;
      #   inherit (config.lib.stylix.colors) base0F;
      # };
      # };

      autopairs.nvim-autopairs.enable = true;

      autocomplete.nvim-cmp = {
        enable = true;
      };

      snippets.luasnip.enable = true;

      filetree = {
        neo-tree = {
          enable = true;
        };
      };

      tabline = {
        nvimBufferline.enable = true;
      };

      treesitter.context.enable = maxConfig;

      binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
      };

      telescope.enable = true;

      git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = false; # throws an annoying debug message
      };

      minimap = {
        minimap-vim.enable = false;
        codewindow.enable = maxConfig; # lighter, faster, and uses lua for configuration
      };

      dashboard = {
        dashboard-nvim.enable = false;
        alpha.enable = maxConfig;
      };

      notify = {
        nvim-notify.enable = maxConfig;
      };

      projects = {
        project-nvim.enable = false;
      };

      mini.surround.enable = false;

      utility = {
        snacks-nvim.enable = maxConfig;
        nix-develop.enable = maxConfig;
        ccc.enable = false;
        vim-wakatime.enable = false;
        diffview-nvim.enable = true;
        yanky-nvim.enable = false;
        icon-picker.enable = maxConfig;
        surround = {
          enable = true;
          useVendoredKeybindings = false;
        };
        leetcode-nvim.enable = false;
        multicursors.enable = true;

        motion = {
          hop.enable = maxConfig;
          precognition.enable = false;
        };
        images = {
          image-nvim.enable = false;
        };
      };

      notes = {
        neorg.enable = false;
        orgmode.enable = false;
        todo-comments.enable = true; # tmp true;
      };

      terminal = {
        toggleterm = {
          enable = true;
          lazygit.enable = true;
        };
      };

      ui = {
        borders.enable = false;
        noice.enable = maxConfig;
        colorizer.enable = true;
        modes-nvim.enable = false; # the theme looks terrible with catppuccin # TEST: à tester
        illuminate.enable = true;
        breadcrumbs = {
          enable = maxConfig;
          navbuddy.enable = maxConfig;
        };
        smartcolumn = {
          enable = false;
          setupOpts.custom_colorcolumn = {
            # this is a freeform module, it's `buftype = int;` for configuring column position
            nix = "110";
            ruby = "120";
            java = "130";
            go = [
              "90"
              "130"
            ];
          };
        };
        fastaction.enable = true;
      };

      assistant = {
        chatgpt.enable = false;
        copilot = {
          enable = false;
          cmp.enable = false;
        };
        codecompanion-nvim.enable = false;
      };

      session = {
        nvim-session-manager = {
          enable = maxConfig;
          setupOpts = {
            autoload_mode = "CurrentDir";
            autosave_ignore_dirs = [
              "/home/${username}"
              "/home/${username}/Downloads"
              "/home/${username}/tmp"
            ];
          };
        };
      };

      gestures = {
        gesture-nvim.enable = false;
      };

      comments = {
        comment-nvim.enable = true;
      };

      presence = {
        neocord.enable = maxConfig;
      };
    };
  };

  options = {
    programs.nvf.maxConfig = lib.mkEnableOption "Enable heavier nvf config"; # // { default = true; };
  };
}
