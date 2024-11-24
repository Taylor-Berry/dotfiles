local M = {
  "mrjones2014/legendary.nvim",
  priority = 10000,
  dependencies = "kkharji/sqlite.lua",
}

function M.config()
  local legendary = require "legendary"

  legendary.setup {
    select_prompt = "Legendary",
    include_builtin = false,
    extensions = {
      codecompanion = false,
      lazy_nvim = true,
      which_key = false,
    },
    -- Load these with the plugin to ensure they are loaded before any Neovim events
    autocmds = require "config.autocmds",
  }

  legendary.keymaps {
    {
      "<C-p>",
      function()
        legendary.find()
      end,
      description = "Open Legendary",
    },
  }
end

return M
