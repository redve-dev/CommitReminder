local function is_git()
	local t = vim.fn.system({"git", "status"}):sub(1, 5)
	return t ~= "fatal"
end

local function print_git()
	local message = "I am not in a git repo"
	if is_git() then
		message = "I am in a git repo"
	end
	print(message)
end

local function count_diff()
	local diff = vim.fn.system({"git", "diff", "--numstat"})
	--https://stackoverflow.com/questions/1426954/split-string-in-lua
	-- fr, lua has tons of string methods, but not a split??
	local function mysplit (inputstr, sep)
		if sep == nil then
			sep = "%s"
		end
		local t={}
		for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
			table.insert(t, str)
		end
		return t
	end
	local lines = mysplit(diff, "	")
	local added = tonumber(lines[1])
	local removed = tonumber(lines[2])
	print("added: "..added)
	print("removed: "..removed)
end

return {
	print_git = print_git,
	count_diff = count_diff,
}
