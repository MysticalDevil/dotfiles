function _in_git_repo
    command git rev-parse --is-inside-work-tree >/dev/null 2>&1
end

alias del 'trash-put'
alias rm 'rm -I --preserve-root --'

# Keep an explicit ls alias, with a safe fallback if eza is unavailable.
if type -q eza
    alias ls 'eza --icons=auto'
else
    alias ls 'command ls --color=auto'
end

function l
    if type -q eza; and type -q git; and _in_git_repo
        command eza -lah --git --group-directories-first --icons=auto $argv
    else if type -q lsd
        command lsd -lah --group-dirs=first $argv
    else
        command ls -lah --color=auto $argv
    end
end

function ll
    if type -q eza; and type -q git; and _in_git_repo
        command eza -lh --git --group-directories-first --icons=auto $argv
    else if type -q lsd
        command lsd -lh --group-dirs=first $argv
    else
        command ls -lh --color=auto $argv
    end
end

function la
    if type -q eza; and type -q git; and _in_git_repo
        command eza -lah --all --git --group-directories-first --icons=auto $argv
    else if type -q lsd
        command lsd -lah -a --group-dirs=first $argv
    else
        command ls -lahA --color=auto $argv
    end
end

function lt
    if type -q eza; and type -q git; and _in_git_repo
        command eza --tree --level=2 --git --group-directories-first --icons=auto $argv
    else if type -q lsd
        command lsd --tree --depth=2 $argv
    else if type -q tree
        command tree -L 2 $argv
    else
        printf '%s\n' 'lt: no eza/lsd/tree found' >&2
        return 127
    end
end

function tree
    if type -q lsd
        command lsd --tree --depth=2 $argv
    else if type -q eza
        command eza --tree --level=2 --icons=auto $argv
    else if type -q tree
        command tree -L 2 $argv
    else
        printf '%s\n' 'tree: no lsd/eza/tree found' >&2
        return 127
    end
end
