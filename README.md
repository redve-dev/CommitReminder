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
delay - delay in seconds between next warning will appear.<br>
required_changes - how many lines of code must change, before you will get warnings.<br>
<br>
If you want the plugin to stay quiet, run:
```
!lua require("CommitReminder").Toggle()
```
Run this command again, if you want the plugin to start warning you again.<br>
