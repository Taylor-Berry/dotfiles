local M = {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
    "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
    { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } }, -- Optional: For prettier markdown rendering
    { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves `vim.ui.select`
  },
  config = true,
}

function M.config()
  local wk = require "which-key"
  wk.add {
    { "<C-a>", "<cmd>CodeCompanionAction<cr>", desc = "Code Companion" },
    { "<leader>ca", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Code Companion Chat" },
    { "<leader>cc", "<cmd>CodeCompanionActions<cr>", desc = "Code Companion" },
  }
  require("codecompanion").setup {
    strategies = {
      chat = {
        adapter = "copilot",
      },
      inline = {
        adapter = "copilot",
      },
    },
  }
end

return M
