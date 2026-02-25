# XDG specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_PICTURES_DIR="$HOME/Pictures"
# QT specification
export QT_QPA_PLATFORMTHEME=qt6ct
# Default programs
export EDITOR="nvim" # default editor
export TERMINAL="kitty" # default terminal
export BROWSER="librewolf" # default browser
# FZF options
export FZF_DEFAULT_OPTS="--color 'bg+:#303030,gutter:-1' --prompt='? ' --pointer='‣' --marker='•' --no-separator --keep-right --layout='reverse' --border='none'" # default fzf options
export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS --scheme='path' --tiebreak='end,chunk,index' --preview-window='down' --preview='/usr/bin/ls -Cp --color=always --group-directories-first {2..}' --height='45%' --preview-window=down,30%,sharp" # zoxide fzf integration
export NEWT_COLORS_FILE=$HOME/.config/whiplash/whiplashrc # improved terminal colors
# MISC
export PYTHON_KEYRING_BACKEND=keyring.backends.fail.Keyring # prevent poetry from using keyring
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk # needed by jdtls
export LD_LIBRARY_PATH="/usr/lib/audacity:/usr/lib/inkscape"
# PATH
export PATH="$PATH:/home/user/.local/share/JetBrains/Toolbox/scripts" # added by jetbrains toolbox
export PATH="$PATH:/usr/local/texlive/2024/bin/x86_64-linux" # texlive installation
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin" # mason binaries
export PATH="$PATH:$HOME/.ghcup/bin" # haskell package manager binaries
export PATH="$PATH:/var/lib/flatpak/exports/share"
export PATH="$PATH:/home/user/.local/share/flatpak/exports/share"
export PATH="$PATH:/home/user/.nix-profile/bin"
# ZVM
export PATH="$PATH:$HOME/.zvm/bin"
# Secrets
# ANTHROPIC_API_KEY="$(gpg --quiet --pinentry-mode=loopback --passphrase-file "$HOME/.gnupg/.passphrases/44A2AB01DB6794B0" --decrypt "$HOME/Documents/secrets/anthropic-api-key.txt.gpg" 2> /dev/null)"
# [ -n "$ANTHROPIC_API_KEY" ] && export ANTHROPIC_API_KEY
[ -f ~/.env/ANTHROPIC_API_KEY ] && ANTHROPIC_API_KEY="$(<~/.env/ANTHROPIC_API_KEY)"
[ -f ~/.env/TAVILY_API_KEY ] && TAVILY_API_KEY="$(<~/.env/TAVILY_API_KEY)"
