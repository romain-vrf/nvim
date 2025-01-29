return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "moon", -- Choose "night", "storm", or "day"
    terminal_colors = true,
    styles = {
      comments = { bold =true },
      keywords = { bold = true },
      functions = { bold = true },
    },
    sidebars = { "qf", "vista_kind", "terminal", "packer" },
    day_brightness = 1, -- Adjust this value for overall brightness (0 to 1)
    on_highlights = function(highlights, colors)
      highlights.Comment = { fg = colors.green, italic = true } -- Set comment color to blue and italic
      highlights.Keyword = { fg = colors.magenta, bold = true } -- Make keywords magenta and bold
    end,
    on_colors = function(colors)
      colors.fg = "#ffffff" -- Make text brighter (white in this case)
    end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd([[colorscheme tokyonight]])
  end,
}

