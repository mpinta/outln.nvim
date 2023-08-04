# outln.nvim
An outline plugin for Neovim, kinda.

## What and why?
Plugin provides an interface to easily and quickly jump to a language-specific definition within an open file. Under the hood it uses [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) to find the necessary nodes and [dressing.nvim](https://github.com/stevearc/dressing.nvim) to provide the UI.

## Install
Using **packer** plugin manager:
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
Visit the [dressing.nvim](https://github.com/stevearc/dressing.nvim)'s repository page to check and set your UI configuration options. Don't forget to install supported language's parser using the [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) plugin.

## Configuration
Plugin can be used without any specific setup. However, it provides some configuration options, with the following defaults, that can be overridden.
```lua
local outln = require('outln')

outln.setup({
    after = 'normal zt',
})
```

* `after` option provides setting the command that will be run after jumping to the selected definition.

### Commands
Use the `:Outln` command to open the plugin interface.

## Language support
Currently supported languages are:
* Go
* YAML
* Python
