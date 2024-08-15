LOCALLIB="$HOME/.local/lib"
LOCALSHARE="$HOME/.local/share"
# ------------------- Environment variable --------------------------
export EDITOR="nvim"

export PAGER="bat"
export MANPAGER="bat"

# Nix user's packages binary
export PATH="$HOME/.nix-profile/bin:$PATH"

# Go language environment
export GOMODCACHE="$HOME/.cache/go/pkg/mod"
export GOPATH="$LOCALLIB/go"
export GOBIN="$LOCALLIB/go/bin"
export GO111MODULE=on
export PATH="$(go env GOBIN):$(go env GOPATH)/bin:$PATH"

# Binary files path
export PATH="$HOME/.local/bin:$PATH"

# Cabal - Haskell package manager
export PATH="$HOME/.cabal/bin:$PATH"
# Ghcup - Haskell tool version manager
# export PATH="$HOME/.ghcup/bin:$PATH"

# Cargo - Rust Package manager
export PATH="$HOME/.cargo/bin:$PATH"

# dotNET Tools
export PATH="$HOME/.dotnet/tools:$PATH"

# fnm -- Fast node manager
export PATH="$LOCALSHARE/fnm:$PATH"

# composer -- PHP package manager
# export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# CPAN -- Perl package manager
export PATH="$LOCALLIB/perl5/bin${PATH:+:${PATH}}"
export PERL5LIB="$LOCALLIB/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL_LOCAL_LIB_ROOT="$LOCALLIB/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT="--install_base \"$LOCALLIB/perl5\""
export PERL_MM_OPT="INSTALL_BASE=$LOCALLIB/perl5"

# Deno -- A JavaScript Runtime Writen by Rust
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Bun -- A JavaScript Runtime Writen by Zig
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# NPM -- node package manager
export npm_config_prefix="$HOME/.local"

# PNPM -- Fast, disk space efficient package manager
export PNPM_HOME="$LOCALSHARE/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# coursier -- modern Scala and Java package manager
export PATH="$LOCALSHARE/coursier/bin:$PATH"

# luarocks -- The lua package manager
export PATH="$HOME/.luarocks/bin:$PATH"

# wasmer -- The leading Wasm Runtime supporting WASIX, WASI and Emscripten
export WASMER_DIR="$HOME/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

# Flutter
export FLUTTER_HOME="/opt/flutter"
export PATH="$FLUTTER_HOME/bin:$PATH"
export PATH="$HOME/.pub-cache/bin:$PATH"

# Android SDK
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# DoomEmacs -- another emacs config
export PATH="$HOME/.config/emacs/bin:$PATH"

# Neovide config
export NEOVIDE_FORK=1


# Chrome execuable path
export CHROME_EXECUTABLE="/usr/bin/google-chrome-stable"
