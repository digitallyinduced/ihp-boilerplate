#!/bin/bash -e
# Script to start the local dev server

#use cachix binary cache
cachix authtoken eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1JDU4MDAiLCJqdGkiOiI2ODI2MzM3Ny04ZjA0LTQzNjQtOTc5Zi0yMTdkNDg2MGFjODciLCJzY29wZXMiOiJ0eCJ9.nb37o2CQBt1Fz3MBMppNACdaWDQsjbPvYpPMLgeJ7RI
cachix use digitallyinduced

# Unless the RunDevServer binary is available, we rebuild the .envrc cache with nix-shell
command -v RunDevServer >/dev/null 2>&1 || { echo "PATH_add $(nix-shell --run 'echo $PATH')" > .envrc; }

# Now we have to load the PATH variable from the .envrc cache
direnv allow
eval "$(direnv hook bash)"

# Finally start the dev server
RunDevServer