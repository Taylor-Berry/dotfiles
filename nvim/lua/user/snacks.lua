local M = {
  "folke/snacks.nvim",
  event = "VimEnter",
}

function M.config()
  local snacks = require "snacks"
  local icons = require "user.icons"
  local env = os.getenv "NVIM_ENV" or "personal" 
  local git_cmd;
  if env == "work" then
    git_cmd = "git -C C:/Users/tberry/AppData/Local/nvim status --short --branch --renames"
  else
    git_cmd = "git -C /Users/taylorberry/.config/nvim status --short --branch --renames"
  end
  snacks.setup {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        keys = {

          { icon = icons.ui.File, key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = icons.ui.NewFile, key = "n", desc = "New File", action = ":ene | startinsert" },
          {
            icon = icons.git.Repo,
            key = "p",
            desc = "Find Project",
            action = "<leader>fp",
          },
          {
            icon = icons.ui.History,
            key = "r",
            desc = "Recent Files",
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          { icon = icons.ui.Gear, key = "c", desc = "Config", action = ":e " .. vim.fn.stdpath('config') .. "/init.lua" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = icons.ui.SignOut, key = "q", desc = "Quit", action = "<leader>q" },
        },
        header = {
          [[        ★　✯   🛸                    🪐   .°•       |    
              __     ° ★　•       🛰       __      / \   
             / /   ____ ___  ______  _____/ /_    | O |  
            / /   / __ `/ / / / __ \/ ___/ __ \   | O |  
           / /___/ /_/ / /_/ / / / / /__/ / / /  /| | |\ 
          /_____/\__,_/\__,_/_/ /_/\___/_/ /_/  /_(.|.)_\]],
        },
      },
      sections = {
        { section = "header" },
        {
          pane = 2,
          section = "terminal",
          cmd = " ",
          height = 5,
          padding = 1,
        },
        { section = "keys", gap = 1, padding = 1 },
        { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        {
          pane = 2,
          icon = " ",
          title = "Git Status",
          section = "terminal",
          enabled = true,
          cmd = git_cmd,
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = "startup" },
      },
    },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        wo = { wrap = true }, -- Wrap notifications
      },
    },
  }

  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      pcall(vim.cmd.AlphaRedraw)
    end,
  })

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = { "AlphaReady" },
    callback = function()
      vim.cmd [[
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]]
    end,
  })
end

return M
