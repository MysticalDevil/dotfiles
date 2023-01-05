# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

#
# History
#


# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -v

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install

# -----------------
# Zsh configuration
# -----------------

# Terminal simulator Blur {{{
if [[ $(ps --no-header -p $PPID -o comm) =~ '^yakuake|alacritty|kitty|wezterm|wezterm-gui$' ]]; then
        for wid in $(xdotool search --pid $PPID); do
            xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $wid; done
fi
# }}}

# Autojump plugin
# [[ -s /etc/profile.d/autojump.sh ]] && . /etc/profile.d/autojump.sh

# ------------------- Environment variable --------------------------
# Enable ccache
export PATH="/usr/lib/ccache/bin/:$PATH"

# Customize go env
export GOMODCACHE="$HOME/.cache/go/pkg/mod"
export GOPATH="$HOME/Packages/go"
export PATH="$GOPATH/bin:$PATH"

# Binary file path
export PATH="$HOME/.local/bin:$PATH"

# Google Chrome path
export CHROME_EXECUTABLE="/usr/bin/google-chrome-stable"

# Haskell about setting
export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"

# Coursier binary file; Scala manage tool
export PATH="$PATH:/home/omega/.local/share/coursier/bin"

# Rust tool binary
export PATH="$HOME/.cargo/bin:$PATH"

# dotNET Tools
export PATH="$HOME/.dotnet/tools:$PATH"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="$HOME/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Broot configure
source $HOME/.config/broot/launcher/bash/br

# Tiup database manager
export PATH="$HOME/.tiup/bin:$PATH"

# Ruby gems path
export PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
export GEM_HOME="$HOME/.gem"

# R language path
export R_LIBS_USER="$HOME/Packages/R"
export R_LIBS="$HOME/Packages/R"
export PATH="$R_HOME/bin:$PATH"

# Julia language path
export JULIA_DEPOT_PATH="$HOME/Packages/julia"

# ssh key path
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"

# use vivid to control tools color scheme
export LS_COLORS="$(vivid generate one-dark)"

# Tools configuration
# Ghcup config
# export $GHCUP_INSTALL_BASE_PREFIX/.ghcup/bin

# ----------------------- Alias program -----------------------------
alias hx=helix
alias icat="kitty +kitten icat"

# ------------------------- Modules setting -------------------------
#
# Fzf - A command-line fuzzy finder
#

# ---------------------------------------------------------

# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# show systemd unit status
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

# environment variable
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
  fzf-preview 'echo ${(P)word}'

# git | it is an example. you can change it
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
  'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
  'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
  'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
  'case "$group" in
  "commit tag") git show --color=always $word ;;
  *) git show --color=always $word | delta ;;
  esac'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
  'case "$group" in
  "modified file") git diff $word | delta ;;
  "recent commit object name") git show --color=always $word | delta ;;
  *) git log --color=always $word ;;
  esac'

# tldr
zstyle ':fzf-tab:complete:tldr:argument-1' fzf-preview 'tldr --color always $word'

# show file content
zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
zstyle ':fzf-tab:complete:*:*' fzf-flags --height=100% --preview-window=right:wrap
zstyle ':fzf-tab:complete:*:options' fzf-preview
zstyle ':fzf-tab:complete:*:argument-1' fzf-preview
export LESSOPEN='|~/.config/.lessfilter.sh %s'

# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# enable tmux popup
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
# apply to all command
zstyle ':fzf-tab:*' popup-min-size 50 8
# only apply to 'diff'
zstyle ':fzf-tab:complete:diff:*' popup-min-size 80 12

# ---------------------------------------------------------

# Paman module setting
zstyle ':zim:pacman' frontend 'yay'
zstyle ':zim:pacman' helpers 'aur'

# atuin keybind
# bindkey '^t' _atuin_search_widget

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
# Kitty Integration
autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
