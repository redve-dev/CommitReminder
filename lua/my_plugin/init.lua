local function is_git()
	local t = vim.fn.systemlist({"git", "status"})[1]
	local first_word = t:gmatch("%w+")()
	return first_word ~= "fatal"
end

local function print_git()
	local message = "I am not in a git repo"
	if is_git() then
		message = "I am in a git repo"
	end
	print(message)
end

return {
	print_git = print_git
}
