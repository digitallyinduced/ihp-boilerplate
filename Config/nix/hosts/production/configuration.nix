{ ihp, lib, pkgs, ... }: {
    imports = [
        ./hardware-configuration.nix

        # This sets several default options. It's designed for simple, small apps where the database and app server
        # are on the same host.
        #
        # See https://github.com/digitallyinduced/ihp/blob/master/NixSupport/nixosModules/appWithPostgres.nix for details
        # 
        # For more complex production deployments, consider ihp.nixosModules.app (https://github.com/digitallyinduced/ihp/blob/master/NixSupport/nixosModules/app.nix)
        ihp.nixosModules.appWithPostgres
    ];

    networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 22 80 443 ];
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

    # Logging to AWS CloudWatch
    # services.vector = {
    #     enable = true;
    #     journaldAccess = true;
    #     settings = {
    #         sources.journald = {
    #             type = "journald";
    #             # Log only the services we care about
    #             include_units = ["app.service" "nginx.service" "worker.service"];
    #         };

    #         sinks.out = {
    #             group_name = "CHANGE-ME";
    #             stream_name = "CHANGE-ME";
    #             # Change the region to the correct one, e.g. `us-east-1`
    #             region = "CHANGE-ME";
    #             auth = {
    #                 access_key_id = "CHANGE-ME";
    #                 secret_access_key = "CHANGE-ME";
    #             };
    #             inputs  = ["journald"];
    #             type = "aws_cloudwatch_logs";
    #             compression = "gzip";
    #             encoding.codec = "json";
    #         };
    #     };
    # };

    services.ihp = {
        domain = "CHANGE-ME.com";
        migrations = ./Application/Migration;
        schema = ./Application/Schema.sql;
        fixtures = ./Application/Fixtures.sql;
        sessionSecret = "CHANGE-ME";
        # Uncomment to use a custom database URL
        # databaseUrl = lib.mkForce "postgresql://postgres:...CHANGE-ME";

        additionalEnvVars = {
            # Uncomment to use a custom session secret, ensuring sessions aren't invalidated
            # on each deploy.
            # Learn how to create the secret key in https://ihp.digitallyinduced.com/Guide/deployment.html#ihpsessionsecret
            # IHP_SESSION_SECRET = "CHANGE-ME";

            SMTP_HOST = "email-smtp.eu-west-1.amazonaws.com";
            SMTP_PORT = "587";
            SMTP_ENCRYPTION = "STARTTLS";

            SMTP_USER = "CHANGE-ME";
            SMTP_PASSWORD = "CHANGE-ME";

            AWS_ACCESS_KEY_ID = "CHANGE-ME";
            AWS_SECRET_ACCESS_KEY = "CHANGE-ME";
        };
    };
    # As we use a pre-built AMI on AWS,
    # it is essential to enable automatic updates.
    # @see https://nixos.wiki/wiki/Automatic_system_upgrades
    system.autoUpgrade.enable = true;
    # Keep as is. See https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "25.05";
}