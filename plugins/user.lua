return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  {
    "tpope/vim-surround",
    event = "BufRead",
  },
  {
    "ray-x/go.nvim",
    config = function()
      require("go").setup()

      -- Run gofmt + goimport on save

      local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function() require("go.format").goimport() end,
        group = format_sync_grp,
      })
      local null_ls = require "null-ls"
      local sources = {
        null_ls.builtins.diagnostics.revive,
        null_ls.builtins.formatting.golines.with {
          extra_args = {
            "--max-len=180",
            "--base-formatter=gofumpt",
          },
        },
      }
      -- for go.nvim
      local gotest = require("go.null_ls").gotest()
      local gotest_codeaction = require("go.null_ls").gotest_action()
      local golangci_lint = require("go.null_ls").golangci_lint()
      table.insert(sources, gotest)
      table.insert(sources, golangci_lint)
      table.insert(sources, gotest_codeaction)
      null_ls.setup { sources = sources, debounce = 1000, default_timeout = 5000 }

      -- alternatively
      null_ls.register(gotest)
    end,
  },
}
-- Run gofmt + goimport on save
