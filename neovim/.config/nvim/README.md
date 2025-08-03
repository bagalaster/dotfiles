# nvim-config

## Getting started

This is my neovim config!

## Directory Structure

```
|- init.lua  sourced on launch, invokes the bagalaster module
|- lua
    |- bagalaster  this is where all the non-plugin config goes
        |- init.lua        sourced when bagalaster is required
        |- keymaps.lua     contains the custom keybindings and options I like
        |- lazy.lua        lazy plugin manager - this is where plugins are initialized
    |- plugins  this is where all the plugin config goes
        |- colors.lua      catppuccin colorscheme
        |- lazydev.lua     better devex for configuring nvim
        |- lsp.lua         all the lsp configuration goes here
        |- lualine.lua     configures a nicer statusline
        |- telescope.lua   fuzzy-finding of all kinds, I mostly use for files/grep
        |- treesitter.lua  for syntax highlighting
```
