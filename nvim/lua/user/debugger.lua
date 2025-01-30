local M = {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
}

function M.config()
	local dap = require("dap")
	local dapui = require("dapui")
	local os_name = vim.loop.os_uname().sysname

	-- Helper function to get OS-specific paths
	local function get_path(windows_path, unix_path)
		if os_name == "Windows_NT" then
			return windows_path or ""
		else
			return unix_path or ""
		end
	end

	-- Get the home directory dynamically
	local home = os.getenv("HOME") or os.getenv("USERPROFILE")

	dapui.setup()


	-- .NET Debug adapter setup
	local netcoredbg_path = "/usr/local/bin/netcoredbg/netcoredbg"

	-- Verify the debugger exists before configuring
	if vim.fn.filereadable(netcoredbg_path) == 0 then
		vim.notify(
			"netcoredbg not found at: " .. netcoredbg_path .. "\nPlease check the path or install netcoredbg",
			vim.log.levels.ERROR
		)
		return
	end

	dap.adapters.coreclr = {
		type = "executable",
		command = netcoredbg_path,
		args = { "--interpreter=vscode" },
		options = {
			detached = false,
		},
	}

	dap.configurations.cs = {
		{
			type = "coreclr",
			name = "launch - netcoredbg",
			request = "launch",
			program = function()
				-- Function to find the launch.json by walking up directories
				local function find_launch_json(start_path)
					local current_path = start_path
					while current_path ~= "/" do
						local test_path = current_path .. "/.vscode/launch.json"
						if vim.fn.filereadable(test_path) == 1 then
							return test_path, current_path
						end
						current_path = vim.fn.fnamemodify(current_path, ":h")
					end
					return nil, nil
				end

				local launch_json_path, workspace_root = find_launch_json(vim.fn.getcwd())
				
				if launch_json_path then
					-- Use the program path from launch.json if available
					local launch_json = vim.fn.json_decode(vim.fn.join(vim.fn.readfile(launch_json_path), "\n"))
					local config = launch_json.configurations[1]
					-- Expand the program path relative to the workspace root
					return vim.fn.expand(workspace_root .. "/" .. config.program:gsub("${workspaceFolder}/", ""))
				end
				return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
			end,
			cwd = "${workspaceFolder}",
		},
	}

	-- DAP UI listeners
	dap.listeners.before.attach.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.launch.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated.dapui_config = function()
		dapui.close()
	end
	dap.listeners.before.event_exited.dapui_config = function()
		dapui.close()
	end

	-- Keymaps
	vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })

	local continue = function()
		-- Get the workspace root directory
		local workspace_root = vim.fn.getcwd()
		local launch_json_path = nil

		-- Function to find the launch.json by walking up directories
		local function find_launch_json(start_path)
			local current_path = start_path
			while current_path ~= "/" do
				local test_path = current_path .. "/.vscode/launch.json"
				vim.notify("Checking for launch.json at: " .. test_path, vim.log.levels.INFO)
				if vim.fn.filereadable(test_path) == 1 then
					return test_path, current_path
				end
				current_path = vim.fn.fnamemodify(current_path, ":h")
			end
			return nil, nil
		end

		launch_json_path, workspace_root = find_launch_json(workspace_root)

		if launch_json_path then
			local ok, err = pcall(function()
				-- First try to read and parse the launch.json to validate it
				local launch_json = vim.fn.join(vim.fn.readfile(launch_json_path), "\n")
				vim.fn.json_decode(launch_json) -- This will throw if JSON is invalid
				
				require("dap.ext.vscode").load_launchjs(nil, {
					["coreclr"] = {
						-- Ensure the workspace folder is set correctly
						cwd = workspace_root,
					},
				})
			end)
			
			if not ok then
				vim.notify("Error loading launch.json: " .. err, vim.log.levels.ERROR)
				return
			end
		else
			vim.notify("No launch.json found in parent directories", vim.log.levels.WARN)
		end
		dap.continue()
	end

	vim.keymap.set("n", "<Leader>dc", continue, { desc = "Continue" })
end

return M