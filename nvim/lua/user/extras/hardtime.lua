local M = {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
}

function M.config()
  require("hardtime").setup {
    max_time = 1000,
    hint = true,
  }
end

return M;
