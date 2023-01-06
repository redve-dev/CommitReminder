local is_on = true

local function Toggle()
	is_on = not is_on
end

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
	local changed_lines = split_string(diff, "	|\n")
	local added = 0
	local removed = 0
	for i=1,table.getn(changed_lines),3 do
		added = added + tonumber(changed_lines[i])
		removed = removed + tonumber(changed_lines[i + 1])
	end
	return {added=added, removed=removed}
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
	if not is_on then
		return
	end
	if not is_git()then
		return
	end
	if os.time() - previous_cycle_time <= delay then
		return
	end
	previous_cycle_time = os.time()

	local changes = count_diff()
	if changes.added == nil or changes.removed == nil then
		return
	end
	local changes_sum = changes.added + changes.removed
	if changes_sum > required_changes_to_notify then
		notify_user()
	end
end

local function setup(args)
	if args then
		if args.delay then
			delay = args.delay
		end
		if args.required_changes then
			required_changes_to_notify = args.required_changes
		end
		if args.remind_on_save_only then
			vim.cmd("autocmd BufWritePost * lua require('CommitReminder').cycle()")
			return
		end
	end
	vim.cmd("augroup my_plugin")
	vim.cmd("autocmd!")
	vim.cmd("autocmd TextChanged  * lua require('CommitReminder').cycle()")
	vim.cmd("autocmd TextChangedI * lua require('CommitReminder').cycle()")
	vim.cmd("autocmd TextChangedP * lua require('CommitReminder').cycle()")
	vim.cmd("autocmd TextChangedT * lua require('CommitReminder').cycle()")
	vim.cmd("augroup end")
end

return {
	cycle = cycle,
	setup = setup,
	Toggle = Toggle,
}
