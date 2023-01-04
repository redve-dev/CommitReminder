# CommitReminder
This plugin will remind you to commit your changes, after chosen amount of changed lines.
# Dependencies
The plugin requires [nvim-notify](https://github.com/rcarriga/nvim-notify)

# Installation
[**packer.nvim**](https://github.com/wbthomason/packer.nvim)
```lua
use({"redve-dev/neovim-git-reminder", config = function()
	require("my_plugin").setup({})
end})
```

# Configuration
```lua
use({"redve-dev/neovim-git-reminder", config = function()
	require("my_plugin").setup({
			delay=5,
			required_changes=20
		})
end})
```
