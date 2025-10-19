-- ==========================================================================
--  nvim‑treesitter configuration – with full documentation
-- ==========================================================================

local opts = {
  -- ------------------------------------------------------------------
  -- Parsers that we want to keep installed.
  --
  -- `ensure_installed` lists the language parsers that will be kept in
  -- sync.  If a parser is missing, it will be automatically downloaded
  -- (see `auto_install`).  The list below contains common languages
  -- plus some domain‑specific ones.
  -- ------------------------------------------------------------------
  ensure_installed = {
    -- Essentials -------------------------------------------------------
    "bash",
    "comment",
    "diff",
    "dockerfile",
    "editorconfig",
    "gitignore",
    "make",
    "markdown",
    "regex",
    "toml",
    "yaml",
    "json",
    "lua",
    "proto",
    "sql",

    -- Graphviz & Mermaid ----------------------------------------------
    "dot",
    "mermaid",

    -- Go ---------------------------------------------------------------
    "go",
    "gomod",
    "gosum",
    "gotmpl",
    "gowork",

    -- JavaScript / TypeScript -----------------------------------------
    "javascript",
    "typescript",
    "tsx",

    -- Python ------------------------------------------------------------
    "python",
  },

  -- ------------------------------------------------------------------
  -- Installation behavior
  --
  -- `sync_install` – if true, the parsers are compiled in a blocking
  -- fashion.  Set to false to keep the compilation asynchronous.
  --
  -- `auto_install` – when opening a file whose parser is missing,
  -- Treesitter will automatically download and install it.
  -- ------------------------------------------------------------------
  sync_install = false, -- compile in background (async)
  auto_install = true, -- install missing parsers on demand

  -- ------------------------------------------------------------------
  -- Core features
  --
  -- Highlighting ----------------------------------------------
  highlight = {
    enable = true, -- turn on syntax highlighting
    additional_vim_regex_highlighting = false, -- keep it off for performance
  },

  -- Indentation ------------------------------------------------------
  indent = {
    enable = true,
    disable = { "python" }, -- Python has its own indentation plugin
  },

  -- ------------------------------------------------------------------
  -- Incremental selection – “expand / shrink” a node with the cursor.
  --
  -- The keymap names are taken from the built‑in Treesitter module.
  -- ------------------------------------------------------------------
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>", -- start selection
      node_incremental = "<C-space>", -- expand to next larger node
      scope_incremental = "<C-s>", -- expand to the current scope
      node_decremental = "<BS>", -- shrink back
    },
  },

  -- ------------------------------------------------------------------
  -- Textobjects – select/move inside functions, classes, parameters…
  --
  -- Each mapping is a table with:
  --   * `query`         – the Treesitter query string.
  --   * `query_group`   – optional group (e.g. "locals" for scopes).
  --   * `desc`          – short description shown in <leader>?
  --
  -- Example: pressing "]m" will jump to the start of the next function.
  -- ------------------------------------------------------------------
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- automatically jump to first match
      keymaps = {
        ["af"] = { query = "@function.outer", desc = "Select outer function" },
        ["if"] = { query = "@function.inner", desc = "Select inner function" },

        ["ac"] = { query = "@class.outer", desc = "Select outer class" },
        ["ic"] = { query = "@class.inner", desc = "Select inner class" },

        ["aa"] = { query = "@parameter.outer", desc = "Select outer parameter" },
        ["ia"] = { query = "@parameter.inner", desc = "Select inner parameter" },
      },
    },

    move = {
      enable = true,
      set_jumps = true, -- add to jumplist

      goto_next_start = {
        ["]m"] = { query = "@function.outer", desc = "Next function start" },
        ["]c"] = { query = "@class.outer", desc = "Next class start" },
        ["]o"] = { query = "@loop.*", desc = "Next loop start" },
        ["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
      },

      goto_next_end = {
        ["]M"] = { query = "@function.outer", desc = "Next function end" },
        ["]C"] = { query = "@class.outer", desc = "Next class end" },
      },

      goto_next = {
        ["]d"] = { query = "@conditional.outer", desc = "Next conditional block" },
      },

      goto_previous_start = {
        ["[m"] = { query = "@function.outer", desc = "Previous function start" },
        ["[c"] = { query = "@class.outer", desc = "Previous class start" },
      },

      goto_previous_end = {
        ["[M"] = { query = "@function.outer", desc = "Previous function end" },
        ["[c"] = { query = "@class.outer", desc = "Previous class end" },
      },

      goto_previous = {
        ["[d"] = { query = "@conditional.outer", desc = "Previous conditional block" },
      },
    },
  },

  -- ------------------------------------------------------------------
  -- Refactor helpers – highlight definitions and easy navigation.
  --
  -- `highlight_definitions` makes it easier to see where a variable is
  -- defined in the current buffer.  `navigation` lets you jump between
  -- definitions using the provided keymaps.
  -- ------------------------------------------------------------------
  refactor = {
    highlight_definitions = {
      enable = true,
      clear_on_cursor_move = false,
    },

    navigation = {
      enable = true,
      keymaps = {
        ["g;"] = "goto_definition", -- jump to definition of symbol under cursor
        ["g,"] = "prev_definition", -- go back to previous definition
      },
    },
  },

  -- ------------------------------------------------------------------
  -- Context‑aware commentstring – automatically set the correct
  -- comment string for the current context.
  -- ------------------------------------------------------------------
  context_commentstring = { enable = true },

  -- ------------------------------------------------------------------
  -- Context‑aware status line / winbar.
  --
  -- Shows the current function/class at the top of the window.
  -- ------------------------------------------------------------------
  context = { enable = true },
}

return opts

-- ==========================================================================
--  HOW TO USE THIS CONFIGURATION IN NVIM
-- ==========================================================================

-- 1. Install Treesitter parsers (once per machine)
--    :TSInstall all        "install all parsers listed in ensure_installed"
--    :TSUpdate             "update all installed parsers"

-- 2. Reload the Neovim configuration or restart to apply changes.

-- 3. Incremental selection
--    <C-space>   – start / expand selection
--    <C-s>       – expand to current scope
--    <BS>        – shrink selection

-- 4. Textobject selections
--    af, if, ac, ic, aa, ia  – use as you would with Vim's built‑in textobjects.

-- 5. Navigation keymaps (example)
--    ]m   – jump to next function start
--    [c   – jump to previous class start
--    g;   – go to definition of symbol under cursor

-- 6. Refactor helpers
--    g;  – goto definition
--    g,  – previous definition

-- Remember: All keymaps defined here are active only if the corresponding
-- module (e.g., `textobjects`, `refactor`) is enabled in this file.
