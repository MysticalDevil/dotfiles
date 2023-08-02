for dir in ${ZDOTDIR:-$HOME}/.config/zsh/*/; do
  if [[ -f ${dir}activate ]]; then
    # Split the files into two arrays
    symbol_files=()
    alpha_files=()
    for file in ${dir}*.zsh; do
      base=$(basename "$file")
      if [ "$base" != "activate" ]; then
        # If the filename starts with a symbol, add it to the symbol_files array
        # else add it to the alpha_files array
        if [[ "$base" =~ ^[^a-zA-Z].* ]]; then
          symbol_files+=("$file")
        else
          alpha_files+=("$file")
        fi
      fi
    done

    # Sort the arrays
    IFS=$'\n' 
    sorted_symbol_files=($(sort <<<"${symbol_files[*]}"))
    sorted_alpha_files=($(sort <<<"${alpha_files[*]}"))
    unset IFS

    # Merge the arrays
    files=("${sorted_symbol_files[@]}" "${sorted_alpha_files[@]}")

    # Now source the files
    for file in "${files[@]}"; do
      # echo "Loading $file"
      source "$file"
    done
  fi
done

source /home/delta/.config/broot/launcher/bash/br
