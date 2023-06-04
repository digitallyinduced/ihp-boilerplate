{
    inputs = {
        ihp.url = "github:digitallyinduced/ihp?ref=abb513016b372f9f76b6c95caed66def536a885a";
        ihp.flake = false;

        nixpkgs.url = "github:NixOS/nixpkgs?rev=a95ed9fe764c3ba2bf2d2fa223012c379cd6b32e";

        systems.url = "github:nix-systems/default";
        devenv.url = "github:cachix/devenv";
    };

    outputs = { self, nixpkgs, devenv, systems, ihp, ... } @ inputs:
        let
            devenvConfig = { pkgs, ... }: {
                # See full reference at https://devenv.sh/reference/options/
                # For IHP specific options, see https://ihp.digitallyinduced.com/Guide/package-management.html

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
            
            releaseEnv = pkgs: import "${ihp}/NixSupport/default.nix" {
                ihp = ihp;
                haskellDeps = (devenvConfig pkgs).ihp.haskellPackages;
                otherDeps = p: (devenvConfig pkgs).packages;
                projectPath = ./.;
                includeDevTools = false;
                optimized = false;
            };
            forEachSystem = nixpkgs.lib.genAttrs (import systems);
        in
            {
                devShells = forEachSystem (system: {
                    default = let pkgs = nixpkgs.legacyPackages.${system}; in devenv.lib.mkShell {
                        inherit inputs pkgs;
                        modules = [devenvConfig];
                    };
                });
                packages = forEachSystem (system: { default = releaseEnv nixpkgs.legacyPackages.${system}; });
            };
    
    nixConfig = {
        extra-substituters = "https://digitallyinduced.cachix.org";
        extra-trusted-public-keys = "digitallyinduced.cachix.org-1:y+wQvrnxQ+PdEsCt91rmvv39qRCYzEgGQaldK26hCKE=";
    };
}