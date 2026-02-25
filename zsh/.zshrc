#!/bin/sh

# History
setopt appendhistory

# Beeping is annoying
unsetopt BEEP

# Better tabs
tabs -4

# Some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete interactive_comments
stty stop undef	# Disable ctrl-s to freeze terminal.

# Disable paste highligting and path underlining
zle_highlight=('paste:none')
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES+=(path none path_prefix none)
ZSH_HIGHLIGHT_DIRS_BLACKLIST=(/*(/))

# Completions
autoload -Uz compinit
zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
# compinit
_comp_options+=(globdots) # Include hidden files.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

[ -f "$ZDOTDIR/zsh-functions" ] && source "$ZDOTDIR/zsh-functions"
[ -f "/usr/local/bin/lfcd" ] && source "/usr/local/bin/lfcd"

zsh_add_file "zsh-vim-mode"
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-prompt"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# For more completions: https://github.com/zsh-users/zsh-completions

# KEYBINDINGS: showkey -a
# For alt+<key> configurations refer to ~/.config/kitty/kitty.conf
# Navigate directories with lf
bindkey -s '^O' 'lf^M' # Ctrl+O
# Navigate and change directories with lf
bindkey -s '^P' 'lfcd^M'
# Goto recent directories
bindkey -s '^F' 'zi^M'
bindkey '^N' autosuggest-accept
# Find recursively and open files
bindkey -s '^H' 'ad_hoc-open^M' # Ctrl+H
# Edit line in vim mode
autoload edit-command-line; zle -N edit-command-line
bindkey '^E' edit-command-line
# Confirm autcompletion
bindkey '^N' autosuggest-accept
# Cancel tab completion
stty intr '^C'

# fzf
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f $ZDOTDIR/completion/_fnm ] && fpath+="$ZDOTDIR/completion/"

scroll-and-clear-screen() {
    printf '\n%.0s' {1..$LINES}
    zle clear-screen
}
zle -N scroll-and-clear-screen
bindkey '^l' scroll-and-clear-screen

compinit
