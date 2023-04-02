# ------------------- Environment variable --------------------------
export EDITOR=nvim

# Go language environment
export GOMODCACHE="$HOME/.cache/go/pkg/mod"
export GOPATH="$HOME/.local/share/go"
export GOBIN="$HOME/.local/share/go/bin"
export GO111MODULE=on
export PATH="$(go env GOBIN):$(go env GOPATH)/bin:$PATH"

# Binary files path
export PATH="$HOME/.local/bin:$PATH"

# Cabal - Haskell package manager
# export PATH="$HOME/.cabal/bin:$PATH"
# Ghcup - Haskell tool version manager
# export PATH="$HOME/.ghcup/bin:$PATH"

# Cargo - Rust Package manager
export PATH="$HOME/.cargo/bin:$PATH"

# dotNET Tools
export PATH="$HOME/.dotnet/tools:$PATH"

# Gems - Ruby gems path
export PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
export GEM_HOME="$HOME/.gem"

# R language files path
export R_LIBS_USER="$HOME/.local/share/R"
export R_LIBS="$HOME/.local/share/R"
export PATH="$R_HOME/bin:$PATH"

# Julia language files path
export JULIA_DEPOT_PATH="$HOME/.local/share/julia"

# SSH Key path
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"

# Use vivid to control tools color scheme
export LS_COLORS="$(vivid generate one-dark)"

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
export npm_config_prefix="$HOME/.local"

# coursier -- modern Scala and Java package manager
export PATH="$HOME/.local/share/coursier/bin:$PATH"
