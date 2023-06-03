{ pkgs, inputs, config, ... }:

{
    # See full reference at https://devenv.sh/reference/options/
    # For IHP specific options, see https://ihp.digitallyinduced.com/Guide/package-management.html

    imports = [
        "${inputs.ihp}/NixSupport/devenv.nix"
    ];

    # https://devenv.sh/packages/
    packages = with pkgs; [
        # Native dependencies, e.g. imagemagick
    ];

    ihp.enable = true;
    ihp.projectPath = ./.;

    ihp.haskellPackages = p: with p; [
        # Haskell dependencies go here
        cabal-install
        base
        wai
        text
        hlint
        ihp
    ];
}
