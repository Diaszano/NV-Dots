return {
  {
    "mason-org/mason.nvim",
    opts = require("configs.mason"),
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require("configs.conform"),
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile", "BufWritePost", "InsertLeave" },
    config = function()
      require("configs.lint")
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("configs.lspconfig")
    end,
  },

  {
    "rshkarin/mason-nvim-lint",
    config = function()
      require("configs.mason.lint")
    end,
    dependencies = {
      "mason-org/mason.nvim",
      "mfussenegger/nvim-lint",
    },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("configs.mason.tool")
    end,
    dependencies = {
      "mason-org/mason.nvim",
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = require("configs.mason.lspconfig"),
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },
  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = require("configs.treesitter"),
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-refactor",
      "nvim-treesitter/nvim-treesitter-context",
    },
  },
}
