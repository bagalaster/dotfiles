# nvim-config

## Getting started

This is my neovim config!

To get started with this config on a new machine:

1. Make sure you have neovim installed. I use brew on macOS, so I would do this:
```bash
brew install neovim
```

2. Make sure you have ripgrep installed. This is required for `telescope` grep usage.
```bash
brew install ripgrep
```

3. Clone the folder into your config folder.
```bash
git clone -- https://github.com/bagalaster/nvim-config.git ${XDG_CONFIG_HOME:-${HOME}/.config/nvim}
```

4. Launch neovim
```bash
nvim .
```

5. Profit

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
