# CommitReminder
This plugin will remind you to commit your changes more often.

https://user-images.githubusercontent.com/106469071/210678434-6e15c60a-62c3-4129-93ea-27168d438494.mp4

# Dependencies
The plugin requires [nvim-notify](https://github.com/rcarriga/nvim-notify)

# Installation
[**packer.nvim**](https://github.com/wbthomason/packer.nvim)
```lua
use({
  "redve-dev/neovim-git-reminder",
  requires = {
    'rcarriga/nvim-notify',
  },
  config = function()
    require("CommitReminder").setup({})
  end
})
```

# Configuration
```lua
require("CommitReminder").setup({
  delay=5,
  required_changes=20,
  remind_on_save_only=true
})
```
delay - Delay in seconds before next warning appears.<br>
required_changes - How many lines of code can change before the warnings appear.<br>
remind_on_save_only - the plugin will prompt you only when you save your file.<br>
<br>
If you want toggle the plugin off and on, run:
```
!lua require("CommitReminder").Toggle()
```
