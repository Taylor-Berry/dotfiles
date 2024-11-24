local M = {
  "folke/which-key.nvim",
}

function M.config()
  local mappings = {

    { "<leader>;", "<cmd>tabnew | terminal<CR>", desc = "Term" },
    { "<leader>c", group = "Code Companion" },
    { "<leader>T", group = "Treesitter" },
    { "<leader>a", group = "Tab" },
    { "<leader>aL", "<cmd>tablast<cr>", desc = "Last Tab" },
    { "<leader>aN", "<cmd>tabnew %<cr>", desc = "New Tab" },
    { "<leader>aP", "<cmd>tabfirst<cr>", desc = "First Tab" },
    { "<leader>ah", "<cmd>-tabmove<cr>", desc = "Move Left" },
    { "<leader>al", "<cmd>+tabmove<cr>", desc = "Move Right" },
    { "<leader>an", "<cmd>$tabnew<cr>", desc = "New Empty Tab" },
    { "<leader>ao", "<cmd>tabonly<cr>", desc = "Only" },
    { "<leader>ap", "<cmd>tabprevious<cr>", desc = "Previous Tab" },
    { "<leader>at", "<cmd>tabnext<cr>", desc = "Next Tab" },
    { "<leader>b", group = "Buffers" },
    { "<leader>d", group = "Debug" },
    { "<leader>f", group = "Find" },
    { "<leader>g", group = "Git" },
    { "<leader>h", "<cmd>nohlsearch<CR>", desc = "NOHL" },
    { "<leader>l", group = "LSP" },
    { "<leader>p", group = "Plugins" },
    { "<leader>q", "<cmd>confirm q<CR>", desc = "Quit" },
    { "<leader>t", group = "Test" },
    { "<leader>v", "<cmd>vsplit<CR>", desc = "Split" },
  }

  local which_key = require "which-key"
  which_key.setup {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = false,
        g = false,
      },
    },
    show_help = false,
    show_keys = false,
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  }

  which_key.add(mappings)
end

return M
