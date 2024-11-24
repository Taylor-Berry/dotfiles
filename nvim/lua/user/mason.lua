local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
}

function M.config()
  -- Detect the environment: default to "personal"
  local env = os.getenv "NVIM_ENV" or "personal"
  local servers = {}
  if env == "personal" then
    servers = {
      "lua_ls",
      "cssls",
      "html",
    }
  elseif env == "work" then
    servers = {
      "lua_ls",
      "cssls",
      "html",
      "csharp_ls",
    }
  end
  require("mason").setup {
    ui = {
      border = "rounded",
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  }

  require("mason-lspconfig").setup {
    ensure_installed = servers,
  }
end

return M
