-- adding colorschemd
function ColorMyPencils(color)
  color = color or "catppuccin-mocha"
  vim.cmd.colorscheme(color)
end

return {
  { 
    "catppuccin/nvim",
    name = "catppuccin", 
    priority = 1000,
    lazy = false,
    opts = {},
    config = function()
      require("catppuccin").setup({
        transparent_background = true
      })
      ColorMyPencils()
    end
  }
}
