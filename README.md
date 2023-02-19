# outln.nvim
An outline plugin for Neovim, kinda.

## What and why?
The plugin provides an interface to easily and quickly jump to a method or function definition within an open file. Under the hood it uses [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) to find the necessary nodes and [dressing.nvim](https://github.com/stevearc/dressing.nvim) to provide the GUI. It's pretty simple and meets my requirements for efficient development.

## Install
Using the **packer** plugin manager:
```lua
use {
    'mpinta/outln.nvim',
    requires = {
        'stevearc/dressing.nvim',
        {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate'
        }
    }
}
```

### Dependencies
Visit the [dressing.nvim](https://github.com/stevearc/dressing.nvim)'s repository page to check and set your configuration options. Don't forget to install supported language's parser using the [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) plugin.

## Configuration
The plugin can be used without any specific setup. However, it provides some configuration options, with the following defaults, that can be overridden.
```lua
local outln = require('outln')

outln.setup({
    after = 'normal zt',
})
```

* The `after` option provides the setting of the command that will be run after jumping to the selected node.

### Commands
Use the `:Outln` command to open the plugin interface.

## Language support
The currently supported languages are:
* Go
