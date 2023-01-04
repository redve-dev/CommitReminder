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

return {
	print_git = print_git
}
