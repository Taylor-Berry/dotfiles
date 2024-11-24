local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

function M.config()
  require("nvim-treesitter.configs").setup {
    ensure_installed = { "lua", "python", "c_sharp", "dockerfile", "typescript", "html" },
    highlight = { enable = true },
    indent = { enable = true },
  }
end

return M
