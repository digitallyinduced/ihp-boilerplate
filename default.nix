let
    haskellEnv = import ./TurboHaskell/NixSupport/default.nix {
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