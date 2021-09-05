let
    ihp = builtins.fetchGit {
        url = "https://github.com/digitallyinduced/ihp.git";
        ref = "6acc01a4e30eac6f4c0962ed9746e974c3bea09f";
    };
    haskellEnv = import "${ihp}/NixSupport/default.nix" {
        ihp = ihp;
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
