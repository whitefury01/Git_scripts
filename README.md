# git-scripts.nvim

Automated git commit and git pull keymaps. Optional asynchronous git commit on
save. A message is generated for the commit which has the date and time in UTC
format.

__Note: Look at the commits for this repo to see the plugin in action 💃.__

## Installation

Requirements:
* bash
* Git

Install with your favorite package manager. Plenary is needed for the
asynchronous functions.

### Packer

```lua
use {
  'declancm/git-scripts.nvim',
  requires = 'nvim-lua/plenary.nvim',
}
```

### Vim-Plug

```vim
Plug 'nvim-lua/plenary.nvim'
Plug 'declancm/git-scripts.nvim'
```

## Usage

### Functions List

```lua
-- Function Arguments

-- message:     The commit message that will be used. The default value is:
--              "Auto Commit: " .. os.date('!%b %d %H:%M:%S %Y') .. " UTC".
--              An empty string ('') input will use the default value.

-- directory:   The path for the directory in which the git commands will be
--              executed. The default value is the current working directory.

-- Git commit and push with full error information on failure.
require("git-scripts").git_commit(message)

-- Git pull with full error information on failure.
require("git-scripts").git_pull()

-- Git commit and push asynchronously. Notify on failure.
require("git-scripts").async_commit(message, directory)

-- Git pull asynchronously. Notify on failure.
require("git-scripts").async_pull(directory)

-- Toggle automatic asynchronous commit on save.
require("git-scripts").toggle_auto_commit()

-- Enable automatic asynchronous commit on save.
require("git-scripts").enable_auto_commit()

-- Disable automatic asynchronous commit on save.
require("git-scripts").disable_auto_commit()
```

### Options

```lua
-- Default options:
require('git-scripts').setup() {
  commit_on_save = false, -- Automatically commit when saving the current buffer.
  default_keymaps = true, -- Use default keymaps.
  warnings = true, -- Display a warning on buffer entry when commit-on-save is active.
}
```

### Default Keymaps

```lua
local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', '<leader>gc', '<Cmd>lua require("git-scripts").async_commit()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>gp', '<Cmd>lua require("git-scripts").async_pull()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>tac', '<Cmd>lua require("git-scripts").toggle_auto_commit()<CR>', opts)
```

### Commit On Save

This will push a git commit with a generated message containing the current date
and time in UTC format, every time the buffer is saved while changes exist.
This occurs asynchronously in the background for maximum convenience.

To disable commit on save for the current session, either use the
default keymap `<leader>tac` to toggle, or enter the command `:DisableCommit`.
