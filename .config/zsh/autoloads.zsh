# Use colors
autoload -U colors && colors
# System completion init
autoload -Uz compinit && compinit
# bashcompinit
autoload -U bashcompinit && bashcompinit
# Enabling Portage completions and Gentoo prompt for zsh
autoload promptinit && promptinit
prompt gentoo
