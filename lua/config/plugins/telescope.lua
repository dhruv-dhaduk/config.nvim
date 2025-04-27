local vscode = require("utils.vscode")

return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },

    config = function()
      require('telescope').setup {
        -- pickers = {
        --   find_files = {
        --     theme = "ivy"
        --   },
        --   help_tags = {
        --     theme = "ivy"
        --   }
        -- },

        extensions = {
          fzf = {}
        }

      }

      vim.keymap.set("n", "<space>fd", require('telescope.builtin').find_files)
      vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags)
      vim.keymap.set("n", "<space>en", function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath("config")
        }
      end)

      vim.keymap.set("n", "<space>ep", function()
        require('telescope.builtin').find_files {
          cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
        }
      end)

      require "config.telescope.multigrep".setup()

      vim.keymap.set("n", "<space>fv", function()
        require('telescope.builtin').find_files({
          attach_mappings = function(_, map)
            -- Map the selection to open in VS Code
            map("i", "<CR>", function(prompt_bufnr)
              local selection = require("telescope.actions.state").get_selected_entry()
              local filepath = selection.path
              -- Open the file in VS Code
              vscode.open_file_in_vscode(filepath)
              require("telescope.actions").close(prompt_bufnr) -- Close the Telescope picker
            end)
            return true
          end,
        })
      end, { noremap = true, silent = true })
    end
  }
}
