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
    end,
  },
}
-- Run gofmt + goimport on save
