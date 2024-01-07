#!/usr/bin/env zsh
# ----------------------- Alias program -----------------------------

# tmux
alias tmux='TERM=xterm-256color tmux'

# python
alias python=python3
alias pip=pip3

# programming
alias gopath="cd $GOPATH/src"
alias goi="go get"
alias gor="go run"
alias gob="go build"
alias gom="go run main.go"
alias goinit="go mod init"
alias rustinit="cargo new"

# project
alias cls="clear" # 清理终端
alias ..="cd .." # 返回上一级
alias 。。="cd .." # 返回上一级
alias ...="cd ../.." # 返回上上级
alias 。。。="cd ../.." # 返回上上级
alias ....="cd ../../.." # 返回上上上级
alias 。。。。="cd ../../.." # 返回上上上级
alias link="npm link" # link 本地包
alias unlink="npm unlink" # unlink 本地包
alias rmmodule="remove !" # 删除node_modules
