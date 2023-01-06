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

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Eliminate duplicate entries in history
setopt HIST_IGNORE_DUPS
