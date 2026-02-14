# Define the directory where we store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
export PATH="$HOME/.local/bin:/opt/homebrew/bin:$PATH"

# If we haven't yet, clone down zinit and source
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Completion is case insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Default completion menu is disabled
zstyle ':completion:*' menu no

# Colorized files
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Show a little prview of the directory contents
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

autoload -U compinit && compinit

# Starship prompt
eval "$(starship init zsh)"

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Keybindings
bindkey '^y' autosuggest-accept
bindkey '^n' history-search-forward
bindkey '^p' history-search-backward

# Nodenv
eval "$(nodenv init - zsh)"

# Zoxide
eval "$(zoxide init zsh)"

# fzf
eval "$(fzf --zsh)"

# Aliases
alias vim=nvim
alias cd=z
alias ls="ls --color"
