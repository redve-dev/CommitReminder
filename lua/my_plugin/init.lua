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

local function notify_user()
	local diff = count_diff()
	local communicate = [[
Remember, to commit your changes
You have +%d -%d lines
]]
	communicate = string.format(communicate, diff.added, diff.removed)
	print(communicate)
end

local previous_cycle_time = 0
local delay <const> = 5
local function cycle()
	if is_git() and os.time() - previous_cycle_time > delay then
		notify_user()
		previous_cycle_time = os.time()
	end
end

return {
	cycle = cycle
}
