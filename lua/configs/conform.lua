local opts = {
  ------------------------------------------------------------------------
  -- 1. FORMATTERS BY FILETYPE
  --
  -- Each key is a Neovim filetype; each value is an ordered list of formatters.
  -- The first formatter is tried first; if it fails, the next one is used.
  ------------------------------------------------------------------------
  formatters_by_ft = {
    -- ───── GO & PYTHON ─────
    go = { "goimports", "gofumpt", "golines" }, -- Go: fmt → gofumpt
    python = { "isort", "black" }, -- Python: sort imports → format

    -- ───── JAVASCRIPT / TYPESCRIPT ─────
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescriptreact = { "prettierd" },

    -- ───── MARKUP / DATA ─────
    json = { "prettierd" },
    toml = { "taplo" },
    yaml = { "yamlfmt" },
    markdown = { "markdownfmt" },

    -- ───── PROTOBUF ─────
    proto = { "buf" },

    -- ───── DOTENV / ENV ─────
    dotenv = { "prettierd" },

    -- ───── SHELL SCRIPTS ─────
    bash = { "shfmt" },
    zsh = { "shfmt" },

    -- ───── MAKEFILES ─────
    make = { "beautysh" }, -- Alternatively: shfmt (if compatible)

    -- ───── DOCKER / JSON / YAML ─────
    dockerfile = { "dockerfmt" }, -- Dockerfiles

    -- ───── LUA ─────
    lua = { "stylua" },
  },

  ------------------------------------------------------------------------
  -- 2. NOTIFY ON ERROR
  --
  -- If true, Conform will show errors via Neovim’s notification API
  ------------------------------------------------------------------------
  notify_on_error = false,

  ------------------------------------------------------------------------
  -- 3. FORMAT ON SAVE
  --
  -- Return a table with options or `nil` to disable formatting for this buffer
  ------------------------------------------------------------------------
  format_on_save = function()
    return {
      timeout_ms = 500, -- Max time (ms) for formatter to finish
      lsp_format = "never", -- 'never' | 'fallback'
    }
  end,

  ------------------------------------------------------------------------
  -- 4. FALLBACK FORMATTERS
  --
  -- If no formatter is defined for a filetype, these are tried.
  ------------------------------------------------------------------------
  fallback_formatters = { "prettierd" },

  ------------------------------------------------------------------------
  -- 5. GLOBAL ENABLE / DISABLE
  ------------------------------------------------------------------------
  enabled = true,
}

return opts
