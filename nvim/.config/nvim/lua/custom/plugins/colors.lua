return {
  -- {
  --   'catppuccin/nvim',
  --   name = 'catppuccin',
  --   priority = 1000,
  --   config = function()
  --     require('catppuccin').setup {
  --       transparent_background = true,
  --     }
  --   end,
  --   init = function()
  --     -- vim.cmd.colorscheme 'catppuccin-mocha'
  --     vim.cmd.colorscheme 'tokyonight-night'
  --     vim.cmd.hi 'Comment gui=none'
  --   end,
  -- },
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- vim.cmd.colorscheme 'catppuccin-mocha'
      vim.cmd.colorscheme 'tokyonight-night'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
