local function is_git()
	local t = vim.fn.system({"git", "status"}):sub(1, 5)
	return t ~= "fatal"
end

local function count_diff()
	local diff = vim.fn.system({"git", "diff", "--numstat"})
	--https://stackoverflow.com/questions/1426954/split-string-in-lua
	-- fr, lua has tons of string methods, but not a split??
	local function split_string(inputstr, sep)
		if sep == nil then
			sep = "%s"
		end
		local t={}
		for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
			table.insert(t, str)
		end
		return t
	end
	local lines = split_string(diff, "	")
	return {added=tonumber(lines[1]), removed=tonumber(lines[2])}
end


local previous_cycle_time = 0
local delay = 5
local required_changes_to_notify = 18
local function notify_user()
	local diff = count_diff()
	local communicate = "Remember, to commit your changes.\nYou have +%d -%d lines"
	communicate = string.format(communicate, diff.added, diff.removed)
	require("notify")(communicate, vim.log.levels.WARN, {title="Git Reminder", timeout=delay})
end

local function cycle()
	if not is_git() or os.time() - previous_cycle_time <= delay then
		return
	end
	previous_cycle_time = os.time()

	local changes = count_diff()
	local changes_sum = changes.added + changes.removed
	if changes_sum > required_changes_to_notify then
		notify_user()
	end
end

local function setup(args)
	if args.delay then
		delay = args.delay
	end

	if args.required_changes then
		required_changes_to_notify = args.required_changes
	end
	vim.cmd("augroup my_plugin")
	vim.cmd("autocmd!")
	vim.cmd("autocmd TextChanged * lua require('my_plugin').cycle()")
	vim.cmd("autocmd TextChangedI * lua require('my_plugin').cycle()")
	vim.cmd("autocmd TextChangedP * lua require('my_plugin').cycle()")
	vim.cmd("autocmd TextChangedT * lua require('my_plugin').cycle()")
	vim.cmd("augroup end")
end

return {
	cycle = cycle,
	setup = setup,
}
