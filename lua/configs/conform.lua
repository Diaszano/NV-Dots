local opts = {
  ------------------------------------------------------------------------
  -- 1. FORMATTERS BY FILETYPE
  --
  --   Each key is a Neovim filetype; each value is an ordered list of formatters
  --   that will be tried in order. If the first fails, the next one is used.
  --
  --   External commands (e.g., "prettier") are fine – Conform simply spawns them.
  ------------------------------------------------------------------------
  formatters_by_ft = {
    go = { "goimports", "gofumpt" }, -- Go: fmt → gofumpt

    python = { "isort", "black" },

    javascript = { "prettier" },
    typescript = { "prettier" },

    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },

    json = { "prettier" },
    toml = { "prettier" },
    yaml = { "prettier" },

    protobuf = { "buf" },

    dotenv = { "prettier" }, -- .env files
  },

  ------------------------------------------------------------------------
  -- 2. NOTIFY ON ERROR
  --
  -- If true, Conform will use Neovim’s notification API to show errors
  -- (e.g., when a formatter fails). Default is false to avoid pop‑ups.
  ------------------------------------------------------------------------
  notify_on_error = false,

  ------------------------------------------------------------------------
  -- 3. FORMAT ON SAVE
  --
  -- The function receives the buffer number (`bufnr`) and must return a table
  -- of options or `nil` to disable auto‑formatting for that buffer.
  --
  -- Example: Disable auto‑format in files matching “*_test.go”.
  ------------------------------------------------------------------------
  format_on_save = function()
    -- local file_name = vim.api.nvim_buf_get_name(bufnr)
    -- if string.match(file_name, ".*_test%.go$") then
    --   return nil
    -- end

    return {
      timeout_ms = 500, -- Max time (ms) for the formatter to finish.
      lsp_format = "never", -- 'never' | 'fallback'
      -- 'never'   – never use LSP; only external formatter.
      -- 'fallback' – try LSP first, then fall back to formatter.
    }
  end,

  ------------------------------------------------------------------------
  -- 4. FALLBACK FORMATTERS
  --
  -- If no formatter is defined for a filetype, these will be tried (in order).
  -- Useful for generic text files.
  ------------------------------------------------------------------------
  fallback_formatters = { "prettier" },

  ------------------------------------------------------------------------
  -- 5. GLOBAL ENABLE/DISABLE
  --
  --   - `true`   – auto‑formatting active for all buffers that have a formatter.
  --   - `false`  – disables auto‑formatting everywhere.
  ------------------------------------------------------------------------
  enabled = true,
}

return opts
