require("nvchad.configs.lspconfig").defaults()

-- ─────────────────────────────────────────────
-- ░░ LANGUAGE SERVERS ░░
-- ─────────────────────────────────────────────
local servers = {
  -- 🐍 Python
  "pyright", -- Python type checking
  "pyrefly", -- Python refactoring/intellisense alternative

  -- 🐹 Go
  "gopls", -- Go language server

  -- 📦 Protobuf
  "bufls", -- Buf LSP for Protobuf
  "protolsp", -- ProtoLint language server (if installed)

  -- 🧾 Markup & Documentation
  "marksman", -- Markdown
  "markdown_oxide", -- Enhanced Markdown LSP
  "vale_ls", -- Vale: prose and grammar checker
  "yaml_language_server", -- YAML (alternative to yamlls)
  "taplo", -- TOML

  -- ⚙️ Shell, Configs, and Infra
  "bashls", -- Bash/Zsh scripts
  "docker_language_server", -- Dockerfiles
  "dotenv_lsp", -- .env files
  "gh_actions_language_server", -- GitHub Actions YAML

  -- 🔡 Spelling, Linting, and Formatting
  "cspell_lsp", -- Code spell checker
  "stylua", -- Lua formatter with LSP support

  -- 🧠 JSON / YAML / Generic
  "jsonls", -- JSON
  "yamlls", -- YAML
}

-- ─────────────────────────────────────────────
-- ░░ ENABLE SERVERS ░░
-- ─────────────────────────────────────────────
for _, lsp in ipairs(servers) do
  vim.lsp.enable(lsp)
end
