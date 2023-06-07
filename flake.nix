{
    inputs.ihp.url = "github:digitallyinduced/ihp/nicolas/flake";  # TODO branch/release

    outputs = { self, ihp }: ihp.inputs.flake-parts.lib.mkFlake { inherit (ihp) inputs; } {

        systems = import ihp.inputs.systems;
        imports = [ ihp.flakeModules.default ];

        perSystem = { pkgs, ... }: {
            devenv.shells.default.packages = with pkgs; [
                # Native dependencies, e.g. imagemagick
            ];

            ihp = {
                enable = true;
                projectPath = ./.;
            };
        };

    };
}
