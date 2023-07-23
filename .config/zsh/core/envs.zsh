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

# fnm -- Fast node manager
export PATH="$HOME/.local/share/fnm:$PATH"

# composer -- PHP package manager
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# Deno -- A JavaScript Runtime Writen by Rust
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Bun -- A JavaScript Runtime Writen by Zig
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# NPM -- node package manager
export npm_config_prefix="$HOME/.local"

# coursier -- modern Scala and Java package manager
export PATH="$HOME/.local/share/coursier/bin:$PATH"

# luarocks -- The lua package manager
export PATH="$HOME/.luarocks/bin:$PATH"

# DoomEmacs -- another emacs config
export PATH="$HOME/.config/emacs/bin:$PATH"
