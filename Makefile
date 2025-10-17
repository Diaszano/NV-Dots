# ==================================================
# 🐻 NV-Dots — Neovim Configurations Makefile
# ==================================================
# Commands:
#   make dev-install   → Setup dev environment
#   make lint          → Run linters (Lua)
#   make fmt           → Auto-format configs (Stylua)
#   make tidy          → Clean up / verify configs
#   make check         → Run all validations
#   make clean         → Clean temporary files
# ==================================================

PKG_DIRS      := ./lua
LINTER        := luacheck
FORMATTER     := stylua

.DEFAULT_GOAL := help

# ==================================================
# 🧰 Setup
# ==================================================
.PHONY: dev-install
dev-install: ## Install development dependencies
	@echo "🔧 Setting up Neovim dev environment..."
	brew update
	brew install neovim lua luacheck rust python
	cargo install stylua
	pip3 install --user pynvim
	pre-commit install --install-hooks

	@# Add cargo bin to PATH if not already
	@if ! echo $$PATH | grep -q '$(CARGO_BIN)'; then \
		echo "export PATH=\"$(CARGO_BIN):$PATH\"" >> ~/.bashrc; \
		echo "export PATH=\"$(CARGO_BIN):$PATH\"" >> ~/.zshrc; \
		echo "⚠️ Added $(CARGO_BIN) to PATH. Reload your shell or run: source ~/.bashrc or source ~/.zshrc"; \
	fi

	@echo "✅ Development environment ready!"

# ==================================================
# 🧹 Lint / Format
# ==================================================
.PHONY: lint
lint: ## Run Lua linter (luacheck)
	@echo "🔍 Running Lua linter..."
	@$(LINTER) --config .luacheckrc $(PKG_DIRS)
	@echo "✅ Lint check completed!"

.PHONY: fmt
fmt: ## Auto-format Lua configs using Stylua
	@echo "🧹 Formatting Lua configs..."
	@$(FORMATTER) --config-path stylua.toml $(PKG_DIRS)
	@echo "✅ Configs formatted successfully!"

# ==================================================
# 🧩 Dependencies / Verification
# ==================================================
.PHONY: tidy
tidy: ## Clean / verify configs (placeholder)
	@echo "🧩 Verifying configurations..."
	@echo "✅ Done!"

# ==================================================
# 🧽 Clean
# ==================================================
.PHONY: clean
clean: ## Remove temporary files
	@echo "🧽 Cleaning temporary files..."
	@rm -f *.swp
	@echo "✅ Clean complete!"

# ==================================================
# ✅ All checks
# ==================================================
.PHONY: check
check: fmt lint tidy ## Run full validation pipeline
	@echo "✅ All checks passed!"

# ==================================================
# 🆘 Help
# ==================================================
.PHONY: help
help:
	@echo "📘 Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'
