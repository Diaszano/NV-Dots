local lint = require("mason-nvim-lint")

lint.setup({
  ------------------------------------------------------------------
  -- A list of linters that should always be present.  Mason will
  -- make sure these are installed on start‑up (unless they’re
  -- explicitly ignored below).  Names must match those in Mason’s
  -- registry, e.g. `"eslint_d"`, `"revive"`.
  --
  -- Example:
  --   ensure_installed = { "eslint_d", "revive" },
  ------------------------------------------------------------------
  ---@type string[]
  ensure_installed = {},

  ------------------------------------------------------------------
  -- If `true` (default), any linter that you register via
  -- `nvim-lint` but is not yet installed will be automatically fetched
  -- from Mason’s registry.  This flag does **not** influence the
  -- `ensure_installed` list above.
  ------------------------------------------------------------------
  ---@type boolean
  automatic_installation = true,

  ------------------------------------------------------------------
  -- Suppress the “Linter X installed” notification that is normally
  -- shown after an auto‑install.  Set to `false` if you want those
  -- messages back.
  ------------------------------------------------------------------
  ---@type boolean
  quiet_mode = true,

  ------------------------------------------------------------------
  -- A list of linters that should never be installed by Mason, even
  -- when they are requested via `nvim-lint`.  This is useful for
  -- linters you ship with your own runtime or that require a custom
  -- build step.
  --
  -- Example:
  --   ignore_install = { "custom_linter" },
  ------------------------------------------------------------------
  ---@type string[]
  ignore_install = {},
})

return lint
