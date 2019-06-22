let
    turboHaskell = builtins.fetchGit {
        url = "https://github.com/digitallyinduced/haskellframework.git";
        rev = "0c82534fce2c6c84ad429e699e817b55cb116533";
    };
    haskellEnv = import "${turboHaskell}/NixSupport/default.nix" {
        compiler = "ghc844";
        haskellDeps = p: with p; [
            cabal-install
            base
            classy-prelude
            blaze-html
            wai
            text
            postgresql-simple
            aeson
            hlint
            generic-lens
            turbohaskell
        ];
        otherDeps = p: with p; [
            # Native dependencies, e.g. imagemagick
        ];
        projectPath = ./.;
    };
in
    haskellEnv