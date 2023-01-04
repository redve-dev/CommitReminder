local function is_git()
	local t = vim.fn.system({"git", "status"}):sub(1, 5)
	return t ~= "fatal"
end

local function count_diff()
	if not is_git() then
		return ""
	end
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
	local added = tonumber(lines[1])
	local removed = tonumber(lines[2])
	return {added= added, removed=removed}
end

return {
	count_diff = count_diff,
}
