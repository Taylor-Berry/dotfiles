local M = {
  "eandrju/cellular-automaton.nvim",
}

function M.config()
  vim.keymap.set("n", "<leader>yr", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Make it Rain" })
  vim.keymap.set("n", "<leader>yg", "<cmd>CellularAutomaton game_of_life<CR>", { desc = "Game of Life" })
end

return M

