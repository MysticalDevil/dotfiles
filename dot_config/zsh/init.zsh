#!/usr/bin/env zsh

ZSH_HOME=$HOME/.config/zsh

source "$ZSH_HOME/_zim.zsh"

source "$ZSH_HOME/aliaes.zsh"
source "$ZSH_HOME/plugins.zsh"


source "$ZSH_HOME/envs.zsh"
source "$ZSH_HOME/third-part.zsh"

for file in "$ZSH_HOME/functions/"*.zsh; do
    source "$file"
done

zle -N zle-line-init # Enable Transient Prompt
# set_wayland_env # Setup wayland necessary envs


# bun completions
[ -s "/home/delta/.bun/_bun" ] && source "/home/delta/.bun/_bun"
