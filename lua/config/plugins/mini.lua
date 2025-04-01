return {
  {
    'echasnovski/mini.nvim',
    config = function()
      local statusline = require 'mini.statusline'
      statusline.setup {}

      require("mini.pairs").setup()
      require("mini.move").setup()
      require("mini.comment").setup()
      require("mini.trailspace").setup()
    end
  }
}
