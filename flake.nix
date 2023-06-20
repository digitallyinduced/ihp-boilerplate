{
    inputs = {
        # TODO use currently up-to-date release of IHP
        ihp.url = "github:digitallyinduced/ihp/nicolas/flake";
        nixpkgs.follows = "ihp/nixpkgs";
        flake-parts.follows = "ihp/flake-parts";
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
                };
            };

        };
}
