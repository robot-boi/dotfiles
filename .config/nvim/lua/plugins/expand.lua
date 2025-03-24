return {
  -- Other plugins...
  {
    "terryma/vim-expand-region",
    lazy = false, -- Optional: Load on startup. Adjust based on your preference.
    config = function()
      -- Key mappings for expanding and shrinking regions
      vim.api.nvim_set_keymap("v", "+", "<Plug>(expand_region_expand)", {})
      vim.api.nvim_set_keymap("v", "-", "<Plug>(expand_region_shrink)", {})
    end,
  },
}
