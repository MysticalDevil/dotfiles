# Broot configure
source "$HOME/.config/broot/launcher/bash/br"

# emsdk -- CXX wasm sdk
export EMSDK_QUIET=1
source "$HOME/.local/share/emsdk/emsdk_env.sh"

# Eliminate duplicate entries in history
setopt HIST_IGNORE_DUPS
