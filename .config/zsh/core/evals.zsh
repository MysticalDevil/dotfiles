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
