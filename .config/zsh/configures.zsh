# Bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Broot configure
source $HOME/.config/broot/launcher/bash/br

# Eliminate duplicate entries in history
setopt HIST_IGNORE_DUPS

# Autojump plugin
# [[ -s /etc/profile.d/autojump.sh ]] && . /etc/profile.d/autojump.sh

# atuin keybind
# bindkey '^t' _atuin_search_widget

# opam configuration
[[ ! -r /home/omega/.opam/opam-init/init.zsh ]] || source /home/omega/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
