# MysticalDevil's Dotfiles

[English](README.md) | [中文](README.zh-CN.md)

Common configuration files for frequently used software on Arch Linux, managed with [`chezmoi`](https://www.chezmoi.io/).

## Highlights

- Shells: [`zsh`](https://www.zsh.org/) with [`zim`](https://zimfw.sh/), plus [`fish`](https://fishshell.com/).
- Terminal multiplexer: [`tmux`](https://github.com/tmux/tmux).
- Terminals: [`alacritty`](https://alacritty.org/), [`kitty`](https://sw.kovidgoyal.net/kitty), [`wezterm`](https://wezfurlong.org/wezterm/index.html).
- Editors: [`helix`](https://helix-editor.com/), [`neovide`](https://neovide.dev/), VS Code settings, and IdeaVim.
- Wayland/Hyprland stack: [`hyprland`](https://hyprland.org/), [`waybar`](https://github.com/Alexays/Waybar), [`wofi`](https://hg.sr.ht/~scoopta/wofi), [`rofi`](https://github.com/davatorium/rofi), [`wlogout`](https://github.com/ArtsyMacaw/wlogout), [`dunst`](https://dunst-project.org/), [`mako`](https://github.com/emersion/mako).
- Media: [`mpd`](https://www.musicpd.org/), [`ncmpcpp`](https://github.com/ncmpcpp/ncmpcpp), [`mpv`](https://mpv.io/), [`imv`](https://sr.ht/~exec64/imv/), [`cava`](https://github.com/karlstav/cava).
- Utilities: [`ranger`](https://github.com/ranger/ranger), fontconfig, GTK themes, and [`fvm`](https://fvm.app/).

## CLI Utilities

See [`.github/MordenCLI.md`](.github/MordenCLI.md).

## ZSH

Configuration: [`dot_zshrc`](dot_zshrc)

Uses zimfw with starship for the shell prompt. zimfw ships with plugins such as `zsh-syntax-highlighting`, `zsh-autosuggestions`, and `zsh-history-substring-search`.

Main plugins:

- [`fzf-tab`](https://github.com/Aloxaf/fzf-tab) improves command/directory completion using `fzf`, with previews.
- `atuin` Rust-based shell history search, shortcut `Ctrl+R`.
- `pacman` zim-provided pacman shortcuts.
- `archive` zim-provided archive shortcuts.
- `ohmyzsh/sudo` double-tap ESC to insert `sudo` at the beginning of the command.
- [`fast-syntax-highlighting`](https://github.com/zdharma-continuum/fast-syntax-highlighting) improved zsh syntax highlighting.
- [`docker-zsh-completion`](https://github.com/greymd/docker-zsh-completion) better Docker and docker-compose completion.
- [`zsh-aliases-exa`](https://github.com/DarrinTisdale/zsh-aliases-exa) uses `exa` to replace `ls` with handy aliases:

  ```shell
  # general use
  alias ls='exa'                                                          # ls
  alias l='exa -lbF --git'                                                # list, size, type, git
  alias ll='exa -lbGF --git'                                             # long list
  alias llm='exa -lbGd --git --sort=modified'                            # long list, modified date sort
  alias la='exa -lbhHigUmuSa --time-style=long-iso --git --color-scale'  # all list
  alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale' # all + extended list

  # specialty views
  alias lS='exa -1'                                                       # one column, just names
  alias lt='exa --tree --level=2'                                         # tree
  ```

- [`forgit`](https://github.com/wfxr/forgit) git helpers powered by fzf with defaults like:

  ```shell
  forgit_log=glo
  forgit_diff=gd
  forgit_add=ga
  forgit_reset_head=grh
  forgit_ignore=gi
  forgit_checkout_file=gcf
  forgit_checkout_branch=gcb
  forgit_checkout_commit=gco
  forgit_clean=gclean
  forgit_stash_show=gss
  forgit_cherry_pick=gcp
  forgit_rebase=grb
  forgit_fixup=gfu
  ```

For more zim plugins, see [`dot_zimrc`](dot_zimrc).

Starship configuration: [`dot_config/starship.toml`](dot_config/starship.toml)

## Fish

Configuration: [`dot_config/fish/config.fish`](dot_config/fish/config.fish)

## Tmux

The `tmux` prefix is mapped to <kbd>Ctrl</kbd>+<kbd>A</kbd> and uses [`tpm`](https://github.com/tmux-plugins/tpm) with plugins:

- [`tmux-sensible`](https://github.com/tmux-plugins/tmux-sensible)
- [`tmux-copycat`](https://github.com/tmux-plugins/tmux-copycat)
- [`tmux-resurrect`](https://github.com/tmux-plugins/tmux-resurrect) and [`tmux-continuum`](https://github.com/tmux-plugins/tmux-continuum)
- [`tmux-pain-control`](https://github.com/tmux-plugins/tmux-pain-control)
- [`tmux-yank`](https://github.com/tmux-plugins/tmux-yank)
- [`tmux-sidebar`](https://github.com/tmux-plugins/tmux-sidebar)
- [`tmux-fzf`](https://github.com/sainnhe/tmux-fzf)
- [`dracula/tmux`](https://github.com/dracula/tmux)

Configuration: [`dot_tmux.conf`](dot_tmux.conf)

## Terminals

- Alacritty: [`dot_config/alacritty/alacritty.yml`](dot_config/alacritty/alacritty.yml)
- WezTerm: [`dot_config/wezterm/wezterm.lua`](dot_config/wezterm/wezterm.lua)
- Kitty: [`dot_config/kitty/kitty.conf`](dot_config/kitty/kitty.conf)

## Hyprland / Wayland

- Hyprland: [`dot_config/hypr`](dot_config/hypr)
- Waybar: [`dot_config/waybar`](dot_config/waybar)
- Wofi: [`dot_config/wofi`](dot_config/wofi)
- Rofi: [`dot_config/rofi`](dot_config/rofi)
- Wlogout: [`dot_config/wlogout`](dot_config/wlogout)
- Dunst: [`dot_config/dunst`](dot_config/dunst)
- Mako: [`dot_config/mako`](dot_config/mako)

## Editors

- Helix: [`dot_config/helix`](dot_config/helix)
- Neovide: [`dot_config/neovide`](dot_config/neovide)
- VS Code: [`dot_config/private_Code/User`](dot_config/private_Code/User)
- IdeaVim: [`dot_ideavimrc`](dot_ideavimrc)

## Media

- MPD: [`dot_config/mpd`](dot_config/mpd)
- ncmpcpp: [`dot_config/ncmpcpp`](dot_config/ncmpcpp)
- MPV: [`dot_config/private_mpv`](dot_config/private_mpv)
- imv: [`dot_config/imv`](dot_config/imv)
- cava: [`dot_config/cava`](dot_config/cava)

## UI and Fonts

- GTK 3: [`dot_config/gtk-3.0`](dot_config/gtk-3.0)
- GTK 4: [`dot_config/private_gtk-4.0`](dot_config/private_gtk-4.0)
- GTK 2: [`dot_config/private_gtk-2.0`](dot_config/private_gtk-2.0)
- Fontconfig: [`dot_config/fontconfig`](dot_config/fontconfig)
