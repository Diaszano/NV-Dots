local mason = require("mason-tool-installer")

mason.setup({
  ------------------------------------------------------------------
  -- A list of tool names that should always be present.  Names are
  -- taken from the Mason registry, e.g. `"eslint_d"`, `"black"`.
  --
  -- Example:
  --   ensure_installed = { "eslint_d", "black", "prettier" },
  ------------------------------------------------------------------
  ---@type string[]
  ensure_installed = {},

  ------------------------------------------------------------------
  -- If `true` (default), Mason will automatically update every tool
  -- in `ensure_installed`.  The updater runs once per day unless
  -- overridden by `debounce_hours`.
  ------------------------------------------------------------------
  auto_update = true,

  ------------------------------------------------------------------
  -- When set to `true`, the installer will run as soon as Neovim
  -- starts.  This is useful for ensuring tools are available before
  -- any language‑server or formatter is invoked.
  ------------------------------------------------------------------
  run_on_start = true,

  ------------------------------------------------------------------
  -- Delay (in milliseconds) between Neovim start and the first run of
  -- the installer.  A small delay gives your UI time to settle.
  --
  -- Default: 3000 ms (3 seconds)
  ------------------------------------------------------------------
  start_delay = 3000,

  ------------------------------------------------------------------
  -- Minimum number of hours that must elapse before an already‑updated
  -- tool is checked again.  This prevents the updater from running too
  -- often and keeps startup fast.
  --
  -- Default: 5 hours
  ------------------------------------------------------------------
  debounce_hours = 5,

  ------------------------------------------------------------------
  -- Optional integrations with other Mason‑powered plugins.
  -- Setting a key to `true` enables automatic installation of tools
  -- required by that plugin.  Leave the key commented out if you do
  -- not wish to integrate.
  --
  -- Example:
  --   integrations = {
  --     ["mason-lspconfig"] = true,
  --     ["mason-nvim-dap"]   = false,  -- explicitly disabled
  --   }
  ------------------------------------------------------------------
  integrations = {
    ["mason-lspconfig"] = true,
    -- ["mason-nvim-dap"] = true,
  },
})

return mason
