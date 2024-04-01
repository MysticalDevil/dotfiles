if status is-interactive
    # Commands to run in interactive sessions can go here
end

source ~/.config/fish/aliases.fish

# ------------------ Third part software ------------------
# Starship prompt
function starship_transent_rmpt_func
    starship module time
end
starship init fish | source
enable_transience

# atuin -- Magical shell history
atuin init fish --disable-up-arrow | source

# zoxide -- A smarter cd command
zoxide init fish --cmd cd | source

# fnm -- fast node manager
fnm env --use-on-cd | source

# ------------------------- Alias -------------------------
