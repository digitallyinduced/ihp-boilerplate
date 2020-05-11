#!/bin/bash -e
# Script to start the local dev server

# Unless the RunDevServer binary is available, we rebuild the .envrc cache with nix-shell
command -v RunDevServer >/dev/null 2>&1 || { echo "PATH_add $(nix-shell --run 'echo $PATH')" > .envrc; }

# Now we have to load the PATH variable from the .envrc cache
direnv allow
eval "$(direnv hook bash)"

# Finally start the dev server
RunDevServer