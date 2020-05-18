let
    ihp = builtins.fetchGit {
        url = "https://github.com/digitallyinduced/haskellframework.git";
        rev = "468072780b38c26582a3b53b7b0a747380dda554";
    };
    haskellEnv = import "${ihp}/NixSupport/default.nix" {
        ihp = ihp;
        compiler = "ghc883";
        haskellDeps = p: with p; [
            cabal-install
            base
            wai
            text
            hlint
            ihp
        ];
        otherDeps = p: with p; [
            # Native dependencies, e.g. imagemagick
        ];
        projectPath = ./.;
    };
in
    haskellEnv
