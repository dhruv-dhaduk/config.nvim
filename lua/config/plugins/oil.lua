local vscode = require("utils.vscode")

return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons

    config = function()
      require("oil").setup({
        view_options = {
          show_hidden = true
        },
        keymaps = {
          ["<space>o"] = function()
            local oil = require("oil")
            local entry = oil.get_cursor_entry()
            if entry and entry.type == "file" then
              local filepath = oil.get_current_dir() .. entry.name
              -- Open the file in VS Code
              vscode.open_file_in_vscode(filepath)
            else
              print("Not a file!")
            end
          end,
        },
      })

      vim.keymap.set("n", "-", "<cmd>Oil<CR>")
    end
  }
}
