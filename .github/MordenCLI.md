# Modern Cli Tools

包括我经常使用的工具：bat、dust、exa、fd、hyperfine、miniserve、ripgrep、just、zoxide 等

其中一些用来替换在 linux 中的常用工具，因为他们更加的人性化、现代化，~~还是 Rust 编写的~~

## Rust 编写

- [`fzf`](https://github.com/junegunn/fzf) 命令行模糊查找器，有一个 Rust 编写的竞品 [`skim`](https://github.com/lotabout/skim)，但是生态并没有 fzf 好

- [`mcfly`](https://github.com/cantino/mcfly) shell 历史记录查找器 ｜ 替代 Ctrl + R

- [`atuin`](https://github.com/ellie/atuin) shell 历史记录工具，mcfly 的竞品，使用 sqlite 取代现有的 shell 历史，能够在多台机器上进行加密传输 ｜替代 Ctrl + R

- [`exa`](https://the.exa.website/) 目录内容概览工具，有一个竞品 `lsd` ，两者功能性上差不多，看个人口味来取舍 ｜ 替代 ls

- [`lsd`](https://github.com/Peltoche/lsd) 目录内容概览的工具，相比 `exa` 可以使用 nerd fonts 的图标来直观的显示文件类型；还提供了 `--tree` 参数，能够替代 tree

- [`broot`](https://github.com/Canop/broot) 目录结构概览工具，使用了 tui 界面，相当于一个简单的文件管理器 ｜ 替代 tree

- [`bat`](https://github.com/sharkdp/bat) 文件内容查看 ｜ 替代 cat

- [`ripgrep`](https://github.com/BurntSushi/ripgrep) 文本搜索 ｜ 替代 grep

- [`fd`](https://github.com/sharkdp/fd) 文件查找 ｜ 替代 find

- [`procs`](https://github.com/dalance/procs) 进程概览 ｜ 替代 ps

- [`zoxide`](https://github.com/ajeetdsouza/zoxide) 目录跳转 ｜ 替代 cd

- [`delta`](https://github.com/dandavison/delta) 文件对比 ｜ 替代 diff

- [`bottom`](https://github.com/ClementTsang/bottom) 系统监视器 ｜ 替代 top/htop

- [`tealdeer`](https://github.com/dbrgn/tealdeer) tldr，速度很快 ｜ 替代 man 和传统 tldr

- [`sd`](https://github.com/chmln/sd) 用于直观的查找和替换CLI ｜ 替代 sed

- [`dust`](https://github.com/bootandy/dust) 查看文件和目录大小的工具，比 du 更加直观，能够显示文件树和文件大小 ｜ 替代 du

- [`dua`](https://github.com/Byron/dua-cli) 查看磁盘空间使用情况的工具，并且能够快速删除不需要的数据 ｜ 替代 df

- [`choose`](https://github.com/theryangeary/choose) 内容截取（文件或者其他的文本输出） ｜ 替代 cut 和 部分 awk

- [`gping`](https://github.com/orf/gping) 网络可用性检查工具，提供了图表 ｜ 替代 ping

- [`tokei`](https://github.com/XAMPPRocky/tokei) 代码统计工具，相比 cloc 它不统计冗余的代码 ｜ 替代 cloc

- [`xh`](https://github.com/ducaale/xh) HTTP 命令行客户端，类似于 httpie，性能更好 ｜ 替代 curl

- [`fnm`](https://github.com/Schniz/fnm) NodeJS 版本管理工具 ｜ 替代 nvm

- [`volta`](https://github.com/volta-cli/volta) NodeJS 版本管理工具 ｜ 替代 nvm

- [`dog`](https://github.com/ogham/dog) DNS 查询工具，提供高亮 ｜ 替代 dig

- [`rip`](https://github.com/nivekuil/rip) 文件删除，比 rm 更加安全 ｜ 替代 rm

- [`xcp`](https://github.com/tarka/xcp) 文件复制，复制时有进度条 ｜ 替代 cp

- [`gix`](https://github.com/Byron/gitoxide) Git 的惯用、精简、快速和安全的纯 Rust 实现

- [`dura`](https://github.com/tkellogg/dura) 用于监视 Git 存储库的后台进程

- [`csview`](https://github.com/wfxr/csview) 快速漂亮的命令行 csv 查看器

- [`watchexec`](https://github.com/watchexec/watchexec) 监视目录文件变动，类似一种热更新

- [`pueue`](https://github.com/) 命令行任务管理工具，用于顺序和并行执行长时间运行的任务

- [`gitoxide`](https://github.com/Byron/gitoxide) git 的 Rust 实现，相比原版 git 更加优雅美观

- [`topgrade`](https://github.com/topgrade-rs/topgrade) 包管理器的升级工具，能够升级系统包、框架包（zimfw，bash-it，oh-my-fish，tmux-tpm）、Runtime包（Bun，Deno）、多版本管理器（rustup，ghcup，asdf，nvm，rbenv）、tldr、git仓库、语言的包管理器（pip，gem，opam，cargo）、固件更新

- [`eva`](https://github.com/nerdypepper/eva) 终端REPL计算器

- [`jql`](https://github.com/yamafaktory/jql) 用于查询处理 JSON 数据的工具

- [`hyperfine`](https://github.com/chinanf-boy/hyperfine) 命令行基准测试工具

- [`hexyl`](https://github.com/sharkdp/hexyl) 文件内容的十六进制的查看工具

- [`vivid`](https://github.com/sharkdp/vivid) LS_COLORS环境变量的生成器，用于控制 ls、tree、fd、bfs 和 dust 许多其他工具的彩色输出

- [`bandwhich`](https://github.com/imsnif/bandwhich) 按进程、连接和远程(IP/主机名)显示当前网络利用率

- [`grex`](https://github.com/pemistahl/grex) 通过测试用例来生成正则表达式的工具

- [`htmlq`](https://github.com/mgdm/htmlq) 类似 jq，用于 HTML 内容的查询，使用 CSS Selector 从 HTML 文件中提取内容

- [`jless`](https://github.com/PaulJuliusMartinez/jless) 命令行 JSON 查看器，专为读取、浏览和搜索 JSON 数据而设计

- [`just`](https://github.com/casey/just) 提供一种保存和运行项目特有命令的便捷方式，类似 make

- [`legdur`](https://hg.sr.ht/~cyplo/legdur) 计算大型目录结构中大型文件集的哈希值，并将它们与以前的快照进行比较

- [`lemmeknow`](https://github.com/swanandx/lemmeknow) 用于识别神秘文本或分析从网络数据包、恶意软件或其他数据中捕获的硬编码字符串

- [`miniserve`](https://github.com/svenstaro/miniserve) 通过 HTTP 来浏览文件和目录的 CLI 工具

- [`pastel`](https://github.com/sharkdp/pastel) 用于在命令行生成、分析、转换和操作颜色

- [`ripsecrets`](https://github.com/sirwart/ripsecrets) 用于防止将密钥提交到源代码中的工具

- [`ouch`](https://github.com/ouch-org/ouch) 命令行压缩解压工具

## Go 编写

- [`duf`](https://github.com/muesli/duf) 查看磁盘空间大小及占用的工具 ｜ 替代 df

- [`curlie`](https://github.com/rs/curlie) HTTP 命令行客户端，相比 httpie 更接近 curl 的语法，但是不提供高亮 ｜ 替代 curl

- [`cheat`](https://github.com/cheat/cheat) 在命令行上创建和查看交互式备忘单，旨在帮助提醒 *nix 系统管理员他们经常使用但不够频繁而无法记住的命令的选项

## Python 编写

- [`glances`](https://github.com/nicolargo/glances) 系统信息概览工具 ｜ 替代 top/htop

- [`httpie`](https://github.com/httpie/httpie) HTTP 命令行客户端，提供了格式化和彩色输出，语法更加语义化 ｜ 替代 curl

## 其他语言编写

- [`ag`](https://github.com/ggreer/the_silver_searcher) 使用 C 编写的代码搜索工具 ｜ 替代 ack

- [`jq`](https://github.com/stedolan/jq) 使用 C 编写的用于处理 JSON 数据的 sed

- [`lesspipe`](https://github.com/wofr06/lesspipe) 使用 Perl编写的 less 的预处理器

- [`chafa`](https://hpjansson.org/chafa/) 将图像数据（包括动画 GIF）转换为适合在终端中显示的图形格式，说人话就是让终端模拟器能显示图片

- [`exiftool`](https://exiftool.org/) 一组可定制的 Perl 模块加上一个全功能的用于广泛读取和写入元信息的命令行应用程序

- [`mediainfo`](https://mediaarea.net/en/MediaInfo) 统一显示视频和音频文件相关的技术和标签数据

- [`git-fuzzy`](https://github.com/bigH/git-fuzzy) 基于 fzf 扩展 git 的工具

  目前支持的子命令

  - `git fuzzy status`
  - `git fuzzy branch`
  - `git fuzzy log`
  - `git fuzzy reflog`
  - `git fuzzy stash`
  - `git fuzzy diff`
  - `git fuzzy pr`

- [`git-extras`](https://github.com/tj/git-extras) git 的扩展工具包，有很多实用的工具封装
