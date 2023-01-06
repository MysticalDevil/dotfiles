# --------------------------- Eval ----------------------------------
# Use zoxide to replace cd command
eval "$(zoxide init zsh --cmd cd)"
# Enable starship
eval "$(starship init zsh)"
# Thefuch plugin
eval "$(thefuck --alias)"
# navi -- An interactive cheatsheet tool for the command-line
eval "$(navi widget zsh)"
# rbenv - ruby virtual environment manager
# eval "$(rbenv init -)"
# Set opam(OCaml package manager) current env
eval "$(opam env --switch=default)"

# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
