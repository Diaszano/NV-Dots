local lint = require("lint")
local from_pattern = require("lint.parser").from_pattern

-- ──────────────────────────────────────────────────────────────
-- ░░ ACTIONLINT ░░
-- GitHub Actions workflow linter
-- ──────────────────────────────────────────────────────────────
lint.linters.actionlint = lint.linters.actionlint
  or {
    cmd = "actionlint",
    stdin = false,
    args = { "--config", ".github/workflows", "--no-color" },
    stream = "stdout",
    parser = from_pattern(
      [[^([^:]+):(%d+):(%d+):\s+(.*)$]],
      { "file", "lnum", "col", "message" },
      nil,
      { source = "actionlint" }
    ),
  }

-- ──────────────────────────────────────────────────────────────
-- ░░ SHELLCHECK ░░
-- Linter for Bash and Zsh scripts
-- ──────────────────────────────────────────────────────────────
local shell_parser = from_pattern(
  [[^([^:]+):(%d+):(%d+):\s+(.*)$]],
  { "file", "lnum", "col", "message" },
  nil,
  { source = "shellcheck" }
)

lint.linters.bash = {
  cmd = "shellcheck",
  stdin = false,
  args = { "--format", "gcc", "-" },
  stream = "stderr",
  parser = shell_parser,
}

lint.linters.zsh = vim.tbl_extend("force", {}, lint.linters.bash)

-- ──────────────────────────────────────────────────────────────
-- ░░ PROTOBUF LINTERS ░░
-- Supports `buf` and `protolint`
-- ──────────────────────────────────────────────────────────────
lint.linters.buf_lint = {
  cmd = "buf",
  args = { "lint", "--error-format=json" },
  parser = function(output)
    local ok, decoded = pcall(vim.fn.json_decode, output)
    if not ok then
      return {}
    end
    local diagnostics = {}
    for _, issue in ipairs(decoded.issues or {}) do
      table.insert(diagnostics, {
        lnum = issue.location.line,
        col = issue.location.column,
        severity = issue.severity == "ERROR" and vim.diagnostic.severity.ERROR or vim.diagnostic.severity.WARN,
        message = issue.message,
        source = "buf_lint",
      })
    end
    return diagnostics
  end,
}

lint.linters.protolint = lint.linters.protolint
  or {
    cmd = "protolint",
    stdin = false,
    args = { "lint", "--error_format", "json" },
    stream = "stdout",
    parser = function(output)
      local ok, decoded = pcall(vim.fn.json_decode, output)
      if not ok or not decoded then
        return {}
      end
      local diagnostics = {}
      for _, d in ipairs(decoded) do
        table.insert(diagnostics, {
          lnum = d.line,
          col = d.column,
          severity = d.level == "ERROR" and vim.diagnostic.severity.ERROR or vim.diagnostic.severity.WARN,
          message = d.message,
          source = "protolint",
        })
      end
      return diagnostics
    end,
  }

-- ──────────────────────────────────────────────────────────────
-- ░░ SPELLCHECK / TYPO DETECTION ░░
-- Supports codespell, cspell, and typos
-- ──────────────────────────────────────────────────────────────
lint.linters.codespell = {
  cmd = "codespell",
  args = { "--ignore-words-list=teh,recieve", "--quiet-level=2" },
  parser = from_pattern(
    [[^([^:]+):(%d+):\s+([^:]+)\s+=>\s+([^:]+)$]],
    { "file", "lnum", "word", "correction" },
    nil,
    { source = "codespell" }
  ),
}

lint.linters.cspell = {
  cmd = "cspell",
  stdin = true,
  args = { "--no-progress", "--no-summary", "--stdin", "--language-id", "plaintext" },
  parser = from_pattern(
    [[^([^:]+):(\d+):\s+([^:]+)\s+(.*)$]],
    { "file", "lnum", "severity", "message" },
    { ["WARNING"] = vim.diagnostic.severity.WARN, ["ERROR"] = vim.diagnostic.severity.ERROR },
    { source = "cspell" }
  ),
}

lint.linters.typos = lint.linters.typos
  or {
    cmd = "typos",
    stdin = false,
    args = { "--format", "json" },
    stream = "stdout",
    parser = function(output)
      local ok, decoded = pcall(vim.fn.json_decode, output)
      if not ok or not decoded then
        return {}
      end
      local diagnostics = {}
      for _, d in ipairs(decoded.diagnostics or {}) do
        table.insert(diagnostics, {
          lnum = (d.range.start.line or 0) + 1,
          col = (d.range.start.character or 0) + 1,
          severity = vim.diagnostic.severity.WARN,
          message = d.message,
          source = "typos",
        })
      end
      return diagnostics
    end,
  }

-- ──────────────────────────────────────────────────────────────
-- ░░ DOTENV / EDITORCONFIG ░░
-- ──────────────────────────────────────────────────────────────
lint.linters.dotenv_linter = {
  cmd = "dotenv-linter",
  args = { "--format", "text" },
  parser = from_pattern([[^([^:]+):(%d+):\s+(.*)$]], { "file", "lnum", "message" }, nil, { source = "dotenv-linter" }),
}

lint.linters.editorconfig_checker = {
  cmd = "editorconfig-checker",
  args = { "--no-color" },
  parser = from_pattern(
    [[^([^:]+):(%d+):(%d+):\s+(.*)$]],
    { "file", "lnum", "col", "message" },
    nil,
    { source = "editorconfig-checker" }
  ),
}

-- ──────────────────────────────────────────────────────────────
-- ░░ GOLANG / PYTHON ░░
-- ──────────────────────────────────────────────────────────────
lint.linters.golangci_lint = lint.linters.golangci_lint
  or {
    cmd = "golangci-lint",
    stdin = false,
    args = { "run", "--out-format", "json" },
    stream = "stdout",
    parser = function(output)
      local ok, decoded = pcall(vim.fn.json_decode, output)
      if not ok or not decoded then
        return {}
      end
      local diagnostics = {}
      for _, issue in ipairs(decoded.Issues or {}) do
        table.insert(diagnostics, {
          lnum = issue.Pos and issue.Pos.Line or 1,
          col = issue.Pos and issue.Pos.Column or 1,
          severity = (issue.Severity == "error") and vim.diagnostic.severity.ERROR or vim.diagnostic.severity.WARN,
          message = issue.Text or issue.FromLinter or "golangci-lint",
          source = "golangci-lint",
        })
      end
      return diagnostics
    end,
  }

lint.linters.ruff = {
  cmd = "ruff",
  args = { "check", "--format", "json", "--exit-zero" },
  parser = function(output)
    local ok, decoded = pcall(vim.fn.json_decode, output)
    if not ok then
      return {}
    end
    local diagnostics = {}
    for _, e in ipairs(decoded) do
      table.insert(diagnostics, {
        lnum = e.location.start.line,
        col = e.location.start.column,
        severity = e.code:sub(1, 1) == "E" and vim.diagnostic.severity.ERROR or vim.diagnostic.severity.WARN,
        message = e.message,
        source = "ruff",
      })
    end
    return diagnostics
  end,
}

-- ──────────────────────────────────────────────────────────────
-- ░░ MISCELLANEOUS ░░
-- For Docker, JSON, Markdown, YAML, etc.
-- hadolint, jsonlint, markdownlint, yamllint keep their default formats
-- ──────────────────────────────────────────────────────────────

-- ──────────────────────────────────────────────────────────────
-- ░░ FILETYPE MAPPING ░░
-- Map linters to filetypes
-- ──────────────────────────────────────────────────────────────
lint.linters_by_ft = {
  yaml = { "yamllint", "cspell", "actionlint" },
  toml = { "cspell" },
  dotenv = { "dotenv_linter", "cspell" },
  dockerfile = { "hadolint" },
  go = { "golangcilint" },
  python = { "ruff" },
  javascript = { "eslint_d", "cspell" },
  typescript = { "eslint_d", "cspell" },
  json = { "jsonlint", "cspell" },
  proto = { "buf_lint", "protolint" },
  markdown = { "markdownlint", "vale", "cspell", "typos" },
  bash = { "bash" },
  zsh = { "zsh" },
  make = { "checkmake" },
  ["yaml.ghaction"] = { "actionlint" },
  ["*"] = { "editorconfig-checker", "codespell", "cspell" },
}

-- ──────────────────────────────────────────────────────────────
-- ░░ AUTOCOMMANDS ░░
-- Automatically lint on buffer enter, write, or insert leave
-- ──────────────────────────────────────────────────────────────
local lint_augroup = vim.api.nvim_create_augroup("Linting", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = vim.schedule_wrap(function()
    lint.try_lint()
  end),
})

return lint
