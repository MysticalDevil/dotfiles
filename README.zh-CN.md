# MysticalDevil's dotfiles

[English](README.md) | [中文](README.zh-CN.md)

目前在 arch linux 系统下的一些常用软件的配置，使用 [`chezmoi`](https://www.chezmoi.io/) 进行管理。

## 重点配置

- Shell：[`zsh`](https://www.zsh.org/)（搭配 [`zim`](https://zimfw.sh/)）以及 [`fish`](https://fishshell.com/)。
- 终端复用器：[`tmux`](https://github.com/tmux/tmux)。
- 终端模拟器：[`alacritty`](https://alacritty.org/)、[`kitty`](https://sw.kovidgoyal.net/kitty)、[`wezterm`](https://wezfurlong.org/wezterm/index.html)。
- 编辑器：[`helix`](https://helix-editor.com/)、[`neovide`](https://neovide.dev/)、VS Code 配置、IdeaVim。
- Wayland/Hyprland：[`hyprland`](https://hyprland.org/)、[`waybar`](https://github.com/Alexays/Waybar)、[`wofi`](https://hg.sr.ht/~scoopta/wofi)、[`rofi`](https://github.com/davatorium/rofi)、[`wlogout`](https://github.com/ArtsyMacaw/wlogout)、[`dunst`](https://dunst-project.org/)、[`mako`](https://github.com/emersion/mako)。
- 多媒体：[`mpd`](https://www.musicpd.org/)、[`ncmpcpp`](https://github.com/ncmpcpp/ncmpcpp)、[`mpv`](https://mpv.io/)、[`imv`](https://sr.ht/~exec64/imv/)、[`cava`](https://github.com/karlstav/cava)。
- 工具：[`ranger`](https://github.com/ranger/ranger)、fontconfig、GTK 主题、[`fvm`](https://fvm.app/)。

## CLI 工具

具体详见 [`.github/MordenCLI.md`](.github/MordenCLI.md)。

## ZSH

具体配置详见 [`dot_zshrc`](dot_zshrc)。

采用 zimfw 框架引入插件，starship 来定义 shell 样式。
zimfw 开箱提供语法高亮 `zsh-syntax-highlighting`、自动建议 `zsh-autosuggestions`、命令记录搜索 `zsh-history-substring-search` 等插件。

主要插件如下：

- [`fzf-tab`](https://github.com/Aloxaf/fzf-tab) 使用 `fzf` 作为引擎提升命令/目录补全，带预览。
- `atuin` 采用 Rust 编写的 shell 历史查询插件，快捷键为 `Ctrl+R`。
- `pacman` zim 提供的 pacman 指令简化插件。
- `archive` zim 提供的压缩命令简化插件。
- `ohmyzsh/sudo` 双击 ESC 在指令最前面插入 sudo。
- [`fast-syntax-highlighting`](https://github.com/zdharma-continuum/fast-syntax-highlighting) 更加友好的 zsh 高亮。
- [`docker-zsh-completion`](https://github.com/greymd/docker-zsh-completion) 更好的 docker 和 docker-compose 补全。
- [`zsh-aliases-exa`](https://github.com/DarrinTisdale/zsh-aliases-exa) 采用 `exa` 替换 `ls`，提供常用 alias：

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

- [`forgit`](https://github.com/wfxr/forgit) 依赖于 fzf 的 git 命令封装工具，一些默认简写：

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

还有一些 zim 开箱提供的插件，具体详见 [`dot_zimrc`](dot_zimrc)。

Starship 配置：[`dot_config/starship.toml`](dot_config/starship.toml)

## Fish

配置文件：[`dot_config/fish/config.fish`](dot_config/fish/config.fish)

## Tmux

`tmux` 的前缀键设置为 <kbd>Ctrl</kbd>+<kbd>A</kbd>，并使用 [`tpm`](https://github.com/tmux-plugins/tpm) 作为插件管理器，插件列表如下：

- [`tmux-sensible`](https://github.com/tmux-plugins/tmux-sensible)
- [`tmux-copycat`](https://github.com/tmux-plugins/tmux-copycat)
- [`tmux-resurrect`](https://github.com/tmux-plugins/tmux-resurrect) 和 [`tmux-continuum`](https://github.com/tmux-plugins/tmux-continuum)
- [`tmux-pain-control`](https://github.com/tmux-plugins/tmux-pain-control)
- [`tmux-yank`](https://github.com/tmux-plugins/tmux-yank)
- [`tmux-sidebar`](https://github.com/tmux-plugins/tmux-sidebar)
- [`tmux-fzf`](https://github.com/sainnhe/tmux-fzf)
- [`dracula/tmux`](https://github.com/dracula/tmux)

具体配置详见 [`dot_tmux.conf`](dot_tmux.conf)。

## 终端模拟器

- Alacritty：[`dot_config/alacritty/alacritty.yml`](dot_config/alacritty/alacritty.yml)
- WezTerm：[`dot_config/wezterm/wezterm.lua`](dot_config/wezterm/wezterm.lua)
- Kitty：[`dot_config/kitty/kitty.conf`](dot_config/kitty/kitty.conf)

## Hyprland / Wayland

- Hyprland：[`dot_config/hypr`](dot_config/hypr)
- Waybar：[`dot_config/waybar`](dot_config/waybar)
- Wofi：[`dot_config/wofi`](dot_config/wofi)
- Rofi：[`dot_config/rofi`](dot_config/rofi)
- Wlogout：[`dot_config/wlogout`](dot_config/wlogout)
- Dunst：[`dot_config/dunst`](dot_config/dunst)
- Mako：[`dot_config/mako`](dot_config/mako)

## 编辑器

- Helix：[`dot_config/helix`](dot_config/helix)
- Neovide：[`dot_config/neovide`](dot_config/neovide)
- VS Code：[`dot_config/private_Code/User`](dot_config/private_Code/User)
- IdeaVim：[`dot_ideavimrc`](dot_ideavimrc)

## 多媒体

- MPD：[`dot_config/mpd`](dot_config/mpd)
- ncmpcpp：[`dot_config/ncmpcpp`](dot_config/ncmpcpp)
- MPV：[`dot_config/private_mpv`](dot_config/private_mpv)
- imv：[`dot_config/imv`](dot_config/imv)
- cava：[`dot_config/cava`](dot_config/cava)

## UI 与字体

- GTK 3：[`dot_config/gtk-3.0`](dot_config/gtk-3.0)
- GTK 4：[`dot_config/private_gtk-4.0`](dot_config/private_gtk-4.0)
- GTK 2：[`dot_config/private_gtk-2.0`](dot_config/private_gtk-2.0)
- Fontconfig：[`dot_config/fontconfig`](dot_config/fontconfig)
