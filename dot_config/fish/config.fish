# Load aliases/functions shared across sessions
source ~/.config/fish/aliases.fish

if status is-interactive
    # Core environment
    set -gx EDITOR nvim

    if type -q bat
        set -gx PAGER bat
        set -gx MANPAGER 'bat -l man -p --paging=always'
    else
        set -gx PAGER less
        set -gx MANPAGER 'less -R'
    end
    set -gx MANROFFOPT -c

    if type -q coursier
        fish_add_path --append --move --path "$HOME/.local/share/coursier/bin"
    end

    # Starship manages prompt rendering itself; disable async-prompt wrapper to avoid conflicts.
    set -g async_prompt_enable 0

    # Starship prompt
    function starship_transient_rprompt_func
        starship module time
    end

    if type -q starship
        starship init fish | source
        enable_transience
    end

    # atuin -- Magical shell history
    if type -q atuin
        atuin init fish --disable-up-arrow | source
    end

    # zoxide -- A smarter cd command
    if type -q zoxide
        zoxide init fish --cmd cd | source
    end
end
