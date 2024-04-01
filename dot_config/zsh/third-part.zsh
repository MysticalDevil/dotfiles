# Broot configure
source "$HOME/.config/broot/launcher/bash/br"

# emsdk -- CXX wasm sdk
export EMSDK_QUIET=1
source "$HOME/.local/share/emsdk/emsdk_env.sh"

# Eliminate duplicate entries in history
setopt HIST_IGNORE_DUPS

# --------------------------- Eval ----------------------------------
# Use zoxide to replace cd command
eval "$(zoxide init zsh --cmd cd)"
# Enable starship
if [[ $TERM != "linux" ]]; then
    eval "$(starship init zsh)"
fi
# Thefuch plugin
eval "$(thefuck --alias)"
# navi -- An interactive cheatsheet tool for the command-line
eval "$(navi widget zsh)"
# fnm -- NodeJS version manager written by Rust
eval "$(fnm env --use-on-cd)"
# pipx -- Install and Run Python Applications in Isolated Environments
eval "$(register-python-argcomplete pipx)"
# atuin -- Magic shell history
eval "$(atuin init zsh --disable-up-arrow)"
# rbenv -- Manage your app's Ruby environment
eval "$(~/.rbenv/bin/rbenv init - zsh)"
# bun -- Incredibly fast JavaScript runtime, bundler, test runner, and package manager – all in one
eval "$(bun completions)"
# deno -- A modern runtime for JavaScript and TypeScript.
eval "$(deno completions zsh)"
# flutter -- Google's UI toolkit for building beautiful, natively compiled applications
# for mobile, web, desktop, and embedded devices from a single codebase.
eval "$(flutter zsh-completion)"
