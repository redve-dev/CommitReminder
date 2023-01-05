# CommitReminder
This plugin will remind you to commit your changes more often.<br>


https://user-images.githubusercontent.com/106469071/210678434-6e15c60a-62c3-4129-93ea-27168d438494.mp4


# Dependencies
The plugin requires [nvim-notify](https://github.com/rcarriga/nvim-notify)

# Installation
[**packer.nvim**](https://github.com/wbthomason/packer.nvim)
```lua
use({"redve-dev/neovim-git-reminder", config = function()
	require("CommitReminder").setup({})
end})
```

# Configuration
```lua
use({"redve-dev/neovim-git-reminder", config = function()
	require("CommitReminder").setup({
			delay=5,
			required_changes=20
		})
end})
```
delay - delay in seconds before next warning appears.<br>
required_changes - how many lines of code can change before the warnings appear.<br>
<br>
If you want toggle the plugin off and on, run:
```
!lua require("CommitReminder").Toggle()
```
