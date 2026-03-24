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
        nixpkgs-nixos.follows = "ihp/nixpkgs-nixos";
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
                        # ihp-mail           # Email support: https://ihp.digitallyinduced.com/Guide/mail.html
                        # ihp-datasync       # Real-time DataSync
                        # ihp-job-dashboard  # Job dashboard UI
                        # ihp-typed-sql      # Type-safe SQL queries
                        # ihp-pglistener     # PostgreSQL LISTEN/NOTIFY
                    ];
                    devHaskellPackages = p: with p; [
                        cabal-install
                        hlint
                        hspec
                        ihp-hspec
                    ];

                    # Hoogle documentation server (enabled by default on port 8002)
                    # withHoogle = false; # Disable to save memory

                    # Disable relation type machinery for faster compilation
                    # relationSupport = false;

                    # Skip tests/haddock for specific packages to speed up builds
                    # dontCheckPackages = [ "my-package" ];
                    # doJailbreakPackages = [ "my-package" ];
                    # dontHaddockPackages = [ "my-package" ];

                    # Production build tuning
                    # optimizationLevel = "2"; # Default: "1", use "2" for more optimized production binaries
                    # rtsFlags = "-A96m -N"; # GHC runtime flags for compiled binaries

                    # Mount additional directories under /static/ in production builds
                    # static.extraDirs = {
                    #     # Frontend = self.packages.${system}.frontend;
                    # };
                    # static.makeBundling = true; # Set false if not using Makefile for CSS/JS bundling
                };

                # Push dev shell and prod server closures to cachix
                # Uncomment and set your cachix cache name
                # apps.push-cachix = let cachixName = "CHANGE-ME"; in {
                #     type = "app";
                #     program = toString (pkgs.writeShellScript "push-cachix" ''
                #         set -eu
                #         echo "Pushing dev shell to cachix..."
                #         nix path-info --recursive ''${self'.devShells.default} | ''${pkgs.cachix}/bin/cachix push ''${cachixName}
                #
                #         echo "Pushing prod server to cachix..."
                #         nix path-info --recursive ''${self'.packages.unoptimized-prod-server} | ''${pkgs.cachix}/bin/cachix push ''${cachixName}
                #     '');
                # };

                # Custom configuration that will start with `devenv up`
                devenv.shells.default = {
                    # Start Mailhog on local development to catch outgoing emails
                    # services.mailhog.enable = true;

                    # PostgreSQL extensions
                    # services.postgres.extensions = extensions: [ extensions.postgis ];

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
