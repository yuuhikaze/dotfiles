ZDOTDIR=/home/user/.config/zsh
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.cache/zsh/history

eval "$(zoxide init zsh)"

[ -f ~/.profile ] && source ~/.profile

# UV
export PATH="/home/user/.local/bin:$PATH"
# LUAROCKS
export LUA_PATH="$HOME/.luarocks/share/lua/5.1/?.lua;$HOME/.luarocks/share/lua/5.1/?/init.lua;$LUA_PATH"
export LUA_CPATH="$HOME/.luarocks/lib/lua/5.1/?.so;$LUA_CPATH"
# FVM
export PATH="$PATH":"$HOME/.pub-cache/bin"
