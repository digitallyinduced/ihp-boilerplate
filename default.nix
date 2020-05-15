let
    turboHaskell = builtins.fetchGit {
        url = "https://github.com/digitallyinduced/haskellframework.git";
        rev = "ac429aa0eb9a5b3f676de5c91722c06c00ce94a1";
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
