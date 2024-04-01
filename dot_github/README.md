# MysticalDevil's dotfiles

目前在 arch linux 系统下的一些常用软件的配置，使用 [`yadm`](https://github.com/TheLocehiliosan/yadm) 进行管理

## 主要软件列表如下

- [`zsh`](https://www.zsh.org/) z shell 是一款可用作交互式登录的 shell 及脚本编写的命令解释器，用来替代`bash`

- [`zim`](https://zimfw.sh/) 模块化、可定制且速度极快的 Zsh 框架，相比 ohmyzsh 更加轻量友好

- [`tmux`](https://github.com/tmux/tmux) 终端复用器

- [`zellij`](https://zellij.dev) 终端复用器，tmux 的竞品，比 tmux 更简单，采用 Rust 编写

- [`fish`](https://fishshell.com/) friendly interactive shell 很傻瓜式的 shell，自身就提供了自动补全、语法高亮等功能，但是语法相比 bash 有很大出入

- [`alacritty`](https://alacritty.org/) 使用 Rust 编写的跨平台的终端模拟器, GPU terminal

- [`kitty`](https://sw.kovidgoyal.net/kitty) 使用 python 和 C 编写的 GPU terminal

- [`starship`](https://starship.rs/) 适用于任何 shell 的最小、极快且可无限自定义的提示符

- [`wezterm`](https://wezfurlong.org/wezterm/index.html) 使用 Rust 编写的跨平台终端模拟器，GPU terminal

## 　实用工具（大多数为 Rust 重构的一些 Unix 经典程序）

具体详见 [`MordenCLI`](MordenCLI.md)

### ZSH

具体配置详见　[`.zshrc`](https://github.com/MysticalDevil/dotfiles/blob/master/.zshrc)

采用　zimfw 框架引入插件，starship 来定义　shell 样式
zimfw 开箱提供了 语法高亮`zsh-syntax-highlighting`、自动建议`zsh-autosuggestions`、命令记录搜索`zsh-history-substring-search` 等插件

主要插件如下

- [`fzf-tab`](https://github.com/Aloxaf/fzf-tab) 使用 `fzf` 作为引擎来提升 命令补全、目录补全等功能，配置了目录预览，文件预览等

- ~~`mcfly` 采用 Rust 编写的 shell 历史查询插件，快捷键为 `Ctrl+R`~~

- `atuin` 采用 Rust 编写的 shell 历史查询插件，快捷键为 `Ctrl+R`

- `pacman` zim 提供的 pacman 指令简化插件

- `archive` zim 提供的压缩命令简化插件

- `ohmyzsh/sudo` ohmyzsh 提供的快速提权插件，通过双击 ESC 在指令最前面插入 sudo

- [`fast-syntax-highlighting`](https://github.com/zdharma-continuum/fast-syntax-highlighting) 使用 `fzf` 作为引擎的 zsh 高亮插件，相比 zsh-syntax-highlighting 提供更加友好的高亮

- [`docker-zsh-completion`](https://github.com/greymd/docker-zsh-completion) 更好的对 docker 和 docker-compose 命令提供补全

- [`zsh-aliases-exa`](https://github.com/DarrinTisdale/zsh-aliases-exa) 采用 `exa` 来替换 ls 命令，并且提供了很多 ls 命令的 alias

  提供的简写如下

  ```shell
  # general use
  alias ls='exa'                                                          # ls
  alias l='exa -lbF --git'                                                # list, size, type, git
  alias ll='exa -lbGF --git'                                             # long list
  alias llm='exa -lbGd --git --sort=modified'                            # long list, modified date sort
  alias la='exa -lbhHigUmuSa --time-style=long-iso --git --color-scale'  # all list
  alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale' # all + extended list

  # specialty views
  alias lS='exa -1'                                                              # one column, just names
  alias lt='exa --tree --level=2'                                         # tree
  ```

- [`forgit`](https://github.com/wfxr/forgit)  依赖于 fzf 的 git 命令封装工具
  一些默认的简写：

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

还有一些 zim 开箱提供的插件，具体详见 [`.zimrc`](https://github.com/MysticalDevil/dotfiles/blob/master/.zimrc)

### Tmux

`tmux` 终端复用器，有两个竞品为 [`byobu`](https://www.byobu.org/) 和 [`zellij`](https://zellij.dev)

tmux 的 &lt;Prefix&gt; 快捷键配置为了 Ctrl+a其中采用了 [`tpm`](https://github.com/tmux-plugins/tpm) 作为插件管理器，插件列表如下

- [`tmux-sensible`](https://github.com/tmux-plugins/tmux-sensible) tmux 的基础选项
- [`tmux-copycat`](https://github.com/tmux-plugins/tmux-copycat) tmux 增强搜索
- [`tmux-resurrect`](https://github.com/tmux-plugins/tmux-resurrect) 和 [`tmux-continuum`](https://github.com/tmux-plugins/tmux-continuum) tmux session 的保存和恢复
- [`tmux-pain-control`](https://github.com/tmux-plugins/tmux-pain-control) tmux 标准 pain 键位绑定
- [`tmux-yank`](https://github.com/tmux-plugins/tmux-yank) 复制到系统剪贴板
- [`tmux-sidebar`](https://github.com/tmux-plugins/tmux-sidebar) 带有当前路径目录树的侧边栏
- [`tmux-fzf`](https://github.com/sainnhe/tmux-fzf) 使用 fzf 来管理 tmux session
- [`dracula/tmux`](https://github.com/dracula/tmux) tmux 的 dracula 主题

具体配置详见 [`.tmux.conf`](https://github.com/MysticalDevil/dotfiles/blob/master/.tmux.conf)

### Alacritty

使用 Rust 编写的 GPU 加速终端模拟器
具体配置详见 [`alacritty.yml`](https://github.com/MysticalDevil/dotfiles/blob/master/.config/alacritty/alacritty.yml)

### WezTerm

使用 Rust 编写的 GPU 加速终端模拟器，相比 Alacritty 速度较慢，但是支持多标签页和分屏等
具体配置详见 [`wezterm.lua`](https://github.com/MysticalDevil/dotfiles/blob/master/.config/wezterm/wezterm.lua)

### Kitty

使用 Python 编写的 GPU 加速终端模拟器，相比 Alacritty 更加友好，有一些内置语法
具体配置详见 [`kitty.conf`](https://github.com/MysticalDevil/dotfiles/blob/master/.config/kitty/kitty.conf)
