local function has_marker_file(marker)
  local marker_path = vim.fn.getcwd() .. "/" .. marker
  return vim.fn.filereadable(marker_path) == 1
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local lsp = require("lspconfig")
      local marker_file = ".nolsp"

      if not has_marker_file(marker_file) then
        lsp.lua_ls.setup { capabilities = capabilities }
        lsp.ccls.setup {
          capabilities = capabilities,
          init_options = {
            compilationDatabaseDirectory = "build",
            clang = {
              extraArgs = {
                "-I/usr/include/c++/11",
                "-I/usr/include/x86_64-linux-gnu/c++/11",
                "-I/usr/include/c++/11/backward",
                "-I/usr/lib/gcc/x86_64-linux-gnu/11/include",
                "-I/usr/local/include",
                "-I/usr/include/x86_64-linux-gnu",
                "-I/usr/include",
              }
            }
          }
        }
        lsp.ts_ls.setup {
          capabilities = capabilities,
          filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
        }
        lsp.tailwindcss.setup { capabilities = capabilities }
        lsp.cmake.setup { capabilities = capabilities }
        lsp.eslint.setup { capabilites = capabilities }
      else
        print("LSP disabled. (.nolsp file found)")
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if client:supports_method('textDocument/formatting') then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              pattern = { "*.lua", "*.c", "*.cpp" },
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })
    end,
  }
}
