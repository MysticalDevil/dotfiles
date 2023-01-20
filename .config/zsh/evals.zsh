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

