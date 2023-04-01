# ------------------- Environment variable --------------------------
export EDITOR=nvim

# Enable ccache - Cache complied files
# export USE_CCACHE=1
# export CCACHE_EXEC=/usr/bin/ccache
# export PATH="/usr/lib/ccache/bin/:$PATH"

# Go language environment
export GOMODCACHE="$HOME/.cache/go/pkg/mod"
export GOPATH="$HOME/Packages/go"
export PATH="$GOPATH/bin:$PATH"

# Binary files path
export PATH="$HOME/.local/bin:$PATH"

# Google Chrome executable file path
# export CHROME_EXECUTABLE="/usr/bin/google-chrome-stable"

# Cabal - Haskell package manager
# export PATH="$HOME/.cabal/bin:$PATH"
# Ghcup - Haskell tool version manager
# export PATH="$HOME/.ghcup/bin:$PATH"

# Coursier - Scala tools manager
# export PATH="$PATH:/home/omega/.local/share/coursier/bin"

# Cargo - Rust Package manager
export PATH="$HOME/.cargo/bin:$PATH"

# dotNET Tools
export PATH="$HOME/.dotnet/tools:$PATH"

# Gems - Ruby gems path
export PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
export GEM_HOME="$HOME/.gem"

# R language files path
export R_LIBS_USER="$HOME/Packages/R"
export R_LIBS="$HOME/Packages/R"
export PATH="$R_HOME/bin:$PATH"

# Julia language files path
export JULIA_DEPOT_PATH="$HOME/Packages/julia"

# SSH Key path
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"

# Use vivid to control tools color scheme
export LS_COLORS="$(vivid generate one-dark)"

# Tools configuration
# Ghcup config
# export $GHCUP_INSTALL_BASE_PREFIX/.ghcup/bin

# Bun executable files
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# fnm -- Fast node manager
export PATH="$HOME/.local/share/fnm:$PATH"

# composer -- PHP package manager
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# Ibus input method
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# Deno -- An JavaScript Runtime
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# NPM -- node package manager
export PATH="$HOME/Packages/npm/bin:$PATH"

# coursier -- modern Scala and Java package manager
export PATH="$HOME/.local/share/coursier/bin:$PATH"
