let
    turboHaskell = builtins.fetchGit {
        url = "https://github.com/digitallyinduced/haskellframework.git";
        rev = "468072780b38c26582a3b53b7b0a747380dda554";
    };
    haskellEnv = import "${turboHaskell}/NixSupport/default.nix" {
        compiler = "ghc883";
        haskellDeps = p: with p; [
            cabal-install
            base
            wai
            text
            hlint
            turbohaskell
        ];
        otherDeps = p: with p; [
            # Native dependencies, e.g. imagemagick
        ];
        projectPath = ./.;
    };
in
    haskellEnv
