local M = {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown", -- Load for markdown files
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required dependency
    -- Add optional dependencies here if needed
  },
}

function M.config()
  require("obsidian").setup({
    workspaces = {
      {
        name = "My Vault",
        path = "~/Library/CloudStorage/GoogleDrive-tcberry1996@gmail.com/My Drive/Obsidian",
      }
    },
    -- Add other options here as needed
  })
end

return M
