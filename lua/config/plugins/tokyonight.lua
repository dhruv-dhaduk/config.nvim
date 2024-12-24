return {
  { 
    "folke/tokyonight.nvim", 
    config = function() 
      require("tokyonight").setup({
        style = "night",
        on_highlights = function(highlights, colors)
          highlights.LineNr = { fg = "#8e96f0", bold = true } 
          highlights.LineNrAbove = { fg = "#7077be" } 
          highlights.LineNrBelow = { fg = "#7077be" } 
        end
      })
      vim.cmd.colorscheme "tokyonight" 
    end 
  }
}
