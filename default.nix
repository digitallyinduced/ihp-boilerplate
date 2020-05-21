let
    ihp = builtins.fetchGit {
        url = "https://github.com/digitallyinduced/haskellframework.git";
        rev = "26946206e99daf6a51467b89838044d09f4f184c";
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
            p.ihp
        ];
        otherDeps = p: with p; [
            # Native dependencies, e.g. imagemagick
        ];
        projectPath = ./.;
    };
in
    haskellEnv
