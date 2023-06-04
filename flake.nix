{
    inputs = {
        # Here you can adjust the IHP version of your project
        # You can find new releases at https://github.com/digitallyinduced/ihp/releases
        ihp.url = "github:digitallyinduced/ihp?ref=abb513016b372f9f76b6c95caed66def536a885a";
        ihp.flake = false;

        # See https://ihp.digitallyinduced.com/Guide/package-management.html#nixpkgs-pinning
        nixpkgs.url = "github:NixOS/nixpkgs?rev=a95ed9fe764c3ba2bf2d2fa223012c379cd6b32e";

        systems.url = "github:nix-systems/default";
        devenv.url = "github:cachix/devenv";
    };

    outputs = { self, nixpkgs, devenv, systems, ihp, ... } @ inputs:
        let
            devenvConfig = { pkgs, ... }: {
                # See full reference at https://devenv.sh/reference/options/
                # For IHP specific options, see https://ihp.digitallyinduced.com/Guide/package-management.html

                # Enable IHP support in devenv.sh
                imports = [ "${inputs.ihp}/NixSupport/devenv.nix" ];
                ihp.enable = true;
                ihp.projectPath = ./.;

                ihp.haskellPackages = p: with p; [
                    # Haskell dependencies go here
                    p.ihp
                    cabal-install
                    base
                    wai
                    text
                    hlint
                ];

                packages = with pkgs; [
                    # Native dependencies, e.g. imagemagick
                ];
            };
            
            # Settings when running `nix build`
            releaseEnv = pkgs: import "${ihp}/NixSupport/default.nix" {
                ihp = ihp;
                haskellDeps = (devenvConfig pkgs).ihp.haskellPackages;
                otherDeps = p: (devenvConfig pkgs).packages;
                projectPath = ./.;

                # Dev tools are not needed in the release build
                includeDevTools = false;

                # Set optimized = true to get more optimized binaries, but slower build times
                optimized = false;
            };
            forEachSystem = nixpkgs.lib.genAttrs (import systems);
        in
            {
                # Dev shells are used for development, e.g. when running `nix develop --impure`
                devShells = forEachSystem (system: {
                    default = let pkgs = nixpkgs.legacyPackages.${system}; in devenv.lib.mkShell {
                        inherit inputs pkgs;
                        modules = [devenvConfig];
                    };
                });
                # Binaries for deploying IHP apps. These are used by `nix build --impure`
                packages = forEachSystem (system: { default = releaseEnv nixpkgs.legacyPackages.${system}; });
            };
    
    # The following is needed to use the IHP binary cache.
    # This binary cache provides binaries for all IHP packages and commonly used dependencies for all nixpkgs versions used by IHP.
    nixConfig = {
        extra-substituters = "https://digitallyinduced.cachix.org";
        extra-trusted-public-keys = "digitallyinduced.cachix.org-1:y+wQvrnxQ+PdEsCt91rmvv39qRCYzEgGQaldK26hCKE=";
    };
}