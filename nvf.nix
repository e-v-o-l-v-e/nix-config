# This is the sample configuration for nvf, aiming to give you a feel of the default options
# while certain plugins are enabled. While it may partially act as one, this is *not* quite
# an overview of nvf's module options. To find a complete and curated list of nvf module
# options, examples, instruction tutorials and more; please visit the online manual.
# https://notashelf.github.io/nvf/options.html
max: {
  config.vim = {
    viAlias = true;
    vimAlias = true;
    debugMode = {
      enable = false;
      level = 16;
      logFile = "/tmp/nvim.log";
    };

    spellcheck = {
      enable = max;
    };

    undoFile.enable = true;
    searchCase = "smart";
    options = {
      cursorlineopt = "line";
      shiftwidth = 2;
      scrolloff = 10;
    };

    lsp = {
      formatOnSave = max;
      lspkind.enable = false;
      lightbulb.enable = max;
      lspsaga.enable = false;
      trouble.enable = max;
      lspSignature.enable = max;
      otter-nvim.enable = true;
      nvim-docs-view.enable = false;
    };

    diagnostics.config = {
      underline.enable = false;
      virtual_lines.enable = true;
    };

    debugger = {
      nvim-dap = {
        enable = max;
        ui.enable = true;
      };
    };

    # This section does not include a comprehensive list of available language modules.
    # To list all available language module options, please visit the nvf manual.
    languages = {
      enableLSP = true;
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;

      # Languages.
      nix = {
        enable = true;
        extraDiagnostics.enable = true;
        treesitter.enable = true;
        format.type = "nixfmt";
        lsp.server = "nixd";
      };
      java.enable = max;
      csharp.enable = max;
      python.enable = max;
      markdown.enable = true;
      yaml.enable = true;
      dart.enable = max;

      lua.enable = max;
      bash.enable = true;
      clang.enable = true;
      css.enable = max;
      html.enable = max;
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
      fidget-nvim.enable = max;

      highlight-undo.enable = true;
      indent-blankline.enable = true;

      # Fun
      cellular-automaton.enable = false;
    };

    statusline = {
      lualine = {
        enable = true;
        theme = "iceberg_dark"; # "catppuccin";
      };
    };

    theme = {
      enable = true;
      name = "tokyonight";
      transparent = true;
      style = "night";
      # name = "catppuccin";
      # style = "mocha";
    };

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

    treesitter.context.enable = max;

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
      codewindow.enable = max; # lighter, faster, and uses lua for configuration
    };

    dashboard = {
      dashboard-nvim.enable = false;
      alpha.enable = max;
    };

    notify = {
      nvim-notify.enable = max;
    };

    projects = {
      project-nvim.enable = false;
    };

    mini.surround.enable = true;

    utility = {
      nix-develop.enable = max;
      ccc.enable = false;
      vim-wakatime.enable = false;
      diffview-nvim.enable = true;
      yanky-nvim.enable = true;
      icon-picker.enable = max;
      surround.enable = true;
      leetcode-nvim.enable = false;
      multicursors.enable = true;

      motion = {
        hop.enable = max;
        precognition.enable = max;
      };
      images = {
        image-nvim.enable = false;
      };
    };

    notes = {
      neorg.enable = false;
      orgmode.enable = false;
      todo-comments.enable = true;
    };

    terminal = {
      toggleterm = {
        enable = true;
        lazygit.enable = true;
      };
    };

    ui = {
      borders.enable = false;
      noice.enable = max;
      colorizer.enable = true;
      modes-nvim.enable = false; # the theme looks terrible with catppuccin # TEST: à tester
      illuminate.enable = true;
      breadcrumbs = {
        enable = max;
        navbuddy.enable = max;
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
      nvim-session-manager.enable = max;
    };

    gestures = {
      gesture-nvim.enable = false;
    };

    comments = {
      comment-nvim.enable = true;
    };

    presence = {
      neocord.enable = max;
    };
  };
}
