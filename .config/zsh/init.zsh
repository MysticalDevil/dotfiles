for dir in ${ZDOTDIR:-$HOME}/.config/zsh/*/; do
  if [[ -f ${dir}activate ]]; then
    # 加载当前目录下的所有 .zsh 文件（除了 activate）
    for file in ${dir}*.zsh; do
      if [ "$(basename "$file")" != "activate" ]; then
        source "$file"
      fi
    done
  fi
done
