# justfile
# -----------
# Defines the recipe for bootstrapping a new workstation

# Brew will install these packages
BREW_DEPS := 'stow neovim ripgrep'

# These modules from the repo will be stowed by default
MODULES := 'zsh oh-my-zsh neovim'

configure: (install-deps) (stow MODULES)

stow apps:
    #!/usr/bin/env zsh
    apps=({{apps}})
    for app in $apps; do
        stow -v -R -t ${HOME} $app
    done

install-deps:
    #!/usr/bin/env zsh
    brew install {{BREW_DEPS}}

