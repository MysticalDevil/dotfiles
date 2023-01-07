if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Starship prompt
function starship_transent_rmpt_func
  starship module time
end
starship init fish | source
enable_transience

