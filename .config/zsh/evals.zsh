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
# fnm -- NodeJS version manager written by Rust
eval "$(fnm env --use-on-cd)"
# rbenv -- Simple ruby version manager
eval "$(rbenv init -)"
# pipx -- Install and Run Python Applications in Isolated Environments
eval "$(register-python-argcomplete pipx)"
