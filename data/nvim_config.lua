require "nvchad.options"

-- try dissableing windwp/nvim-autopairs

vim.api.nvim_create_user_command(
  'Style',
  function(opts)
	local filename = vim.fn.expand('%:t')

	-- Set options
	vim.opt.whichwrap = "b,s"
	vim.opt.wrap = false
	vim.opt.autoindent = true
	vim.opt.tabstop = 4 -- Size of tabs
	vim.opt.shiftwidth = 4 -- Autoindent size

	vim.cmd [[
		highlight TrailingSpaces ctermbg=red guibg=red
		match TrailingSpaces /\s\+$/
	]]


	if opts.args == "" then
		return
	end

	identity = opts.args
	if identity == "epitech" then
		if filename ~= "Makefile" then
			vim.opt.expandtab = true -- Use spaces instead of tabs
		end
		vim.opt.softtabstop = 4 -- Group delete spaces in tabs
	elseif identity == "42" then
		vim.opt.softtabstop = 0
		vim.opt.expandtab = false -- Use tabs instead of spaces
	elseif identity == "personal" then
		vim.opt.expandtab = false -- Use tabs instead of spaces
	else
		error("Not found")
	end

	-- Set colorcolumn based on identity
	if identity == "epitech" then
		vim.opt.colorcolumn = "80"
	elseif identity == "42" then
		vim.opt.colorcolumn = "81"
	else
		vim.opt.colorcolumn = ""
	end

	vim.notify("Settings for " .. identity)
	end,
  { nargs = "?" }
)


-- Get the user's identity from git config
local identity = vim.fn.system('git config user.identity'):gsub("\n", "")

-- Define user variables
if identity == "42" then
	vim.g.user42 = vim.fn.system('git config user.name'):gsub("\n", "")
	vim.g.mail42 = vim.fn.system('git config user.email'):gsub("\n", "")
end

pcall(vim.cmd("Style " .. identity))
