{
    inputs = {
        ihp.url = "github:digitallyinduced/ihp/v1.2";
        nixpkgs.follows = "ihp/nixpkgs";
        flake-parts.follows = "ihp/flake-parts";
        devenv.follows = "ihp/devenv";
        systems.follows = "ihp/systems";
    };

    outputs = inputs@{ ihp, flake-parts, systems, ... }:
        flake-parts.lib.mkFlake { inherit inputs; } {

            systems = import systems;
            imports = [ ihp.flakeModules.default ];

            perSystem = { pkgs, ... }: {
                ihp = {
                    enable = true;
                    projectPath = ./.;
                    packages = with pkgs; [
                        # Native dependencies, e.g. imagemagick
                    ];
                    haskellPackages = p: with p; [
                        # Haskell dependencies go here
                        p.ihp
                        cabal-install
                        base
                        wai
                        text

                        # Uncomment on local development for testing
                        # hspec
                    ];
                };

                # Custom configuration that will start with `devenv up`
                devenv.shells.default = {
                    # Start Mailhog on local development to catch outgoing emails
                    services.mailhog.enable = true;

                    # Custom processes that don't appear in https://devenv.sh/reference/options/
                    processes = {
                        # Uncomment if you use tailwindcss.
                        # tailwind.exec = "tailwindcss -c tailwind/tailwind.config.js -i ./tailwind/app.css -o static/app.css --watch=always";
                    };
                };
            };

            # Adding the new NixOS configuration for "qa"
            # Used to deploy the IHP application to AWS.
            #
            # Change the `CHANGE-ME` to your correct config.
            flake.nixosConfigurations."qa" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = inputs;
                modules = [
                    "${nixpkgs}/nixos/modules/virtualisation/amazon-image.nix"
                    ihp.nixosModules.appWithPostgres
                    ({ lib, pkgs, ... }: {

                        networking.firewall = {
                            enable = true;
                            allowedTCPPorts = [ 22 80 443 8000 ];
                        };

                        # Enable the Let's encrypt certificate
                        security.acme.defaults.email = "CHANGE-ME@example.com";

                        # Accept the terms of service of the Let's encrypt provider.
                        security.acme.acceptTerms = true;

                        services.nginx = {
                            virtualHosts."CHANGE-ME.com" =  {
                                # Uncomment to have http auth with username `foo` and password `bar`.
                                # basicAuth = { foo = "bar"; };
                            };
                        };

                        services.ihp = {
                            domain = "CHANGE-ME.com";
                            migrations = ./Application/Migration;
                            schema = ./Application/Schema.sql;
                            fixtures = ./Application/Fixtures.sql;
                            sessionSecret = "CHANGE-ME";
                            additionalEnvVars = {
                                # Uncomment to use a custom database URL
                                # DATABASE_URL = "postgresql://postgres:...CHANGE-ME";

                                SMTP_HOST = "email-smtp.eu-west-1.amazonaws.com";
                                SMTP_PORT = "587";
                                SMTP_USER = "CHANGE-ME";
                                SMTP_PASSWORD = "CHANGE-ME";

                                # Indicate the environment name, e.g. "production", "staging", "qa".
                                ENV_NAME = "qa";

                                AWS_ACCESS_KEY_ID = "CHANGE-ME";
                                AWS_SECRET_ACCESS_KEY = "CHANGE-ME";
                            };
                        };

                        # Keep as is.
                        system.stateVersion = "23.05";
                    })
                ];
            };

        };
}
