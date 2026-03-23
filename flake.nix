{
    # Change these to your cachix cache name and public key
    # nixConfig = {
    #     extra-substituters = [
    #         "https://CHANGE-ME.cachix.org"
    #     ];
    #     extra-trusted-public-keys = [
    #         "CHANGE-ME.cachix.org-1:CHANGE-ME-PUBLIC-KEY"
    #     ];
    # };

    inputs = {
        ihp.url = "github:digitallyinduced/ihp/v1.5";
        nixpkgs.follows = "ihp/nixpkgs";
        flake-parts.follows = "ihp/flake-parts";
        devenv.follows = "ihp/devenv";
        systems.follows = "ihp/systems";
        devenv-root = {
            url = "file+file:///dev/null";
            flake = false;
        };
    };

    outputs = inputs@{ self, nixpkgs, ihp, flake-parts, systems, ... }:
        flake-parts.lib.mkFlake { inherit inputs; } {

            systems = import systems;
            imports = [ ihp.flakeModules.default ];

            perSystem = { pkgs, lib, config, self', ... }: {
                ihp = {
                    appName = "app"; # Change this to your project name
                    enable = true;
                    projectPath = ./.;
                    packages = with pkgs; [
                        # Native dependencies, e.g. imagemagick
                    ];
                    haskellPackages = p: with p; [
                        # Haskell dependencies go here
                        p.ihp
                        base
                        wai
                        text
                        # ihp-mail
                        # See https://ihp.digitallyinduced.com/Guide/mail.html

                        # Uncomment for testing
                        # hspec
                        # ihp-hspec
                    ];
                    devHaskellPackages = p: with p; [
                        cabal-install
                        # hlint
                        # fourmolu
                    ];
                };

                # Push dev shell and prod server closures to cachix
                # Uncomment and set your cachix cache name
                # apps.push-cachix = let cachixName = "CHANGE-ME"; in {
                #     type = "app";
                #     program = pkgs.writeShellScript "push-cachix" ''
                #         set -eu
                #         echo "Pushing dev shell to cachix..."
                #         nix path-info --recursive ''${self'.devShells.default} | ''${pkgs.cachix}/bin/cachix push ''${cachixName}
                #
                #         echo "Pushing prod server to cachix..."
                #         nix path-info --recursive ''${self'.packages.unoptimized-prod-server} | ''${pkgs.cachix}/bin/cachix push ''${cachixName}
                #     '';
                # };

                # Custom configuration that will start with `devenv up`
                devenv.shells.default = {
                    # Start Mailhog on local development to catch outgoing emails
                    # services.mailhog.enable = true;

                    # Custom processes that don't appear in https://devenv.sh/reference/options/
                    processes = {
                        # Uncomment if you use tailwindcss.
                        # tailwind.exec = "tailwindcss -c tailwind/tailwind.config.js -i ./tailwind/app.css -o static/app.css --watch=always";
                    };
                };
            };

            # Adding the new NixOS configuration for "production"
            # See https://ihp.digitallyinduced.com/Guide/deployment.html#deploying-with-deploytonixos for more info
            # Used to deploy the IHP application
            flake.nixosConfigurations."production" = import ./Config/nix/hosts/production/host.nix { inherit inputs; };
        };
}
