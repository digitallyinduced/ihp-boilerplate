{ inputs }:
inputs.nixpkgs-nixos.lib.nixosSystem {
    system = "x86_64-linux"; # or alternatively: aarch64-linux
    specialArgs = inputs // { nixpkgs = inputs.nixpkgs-nixos; };
    modules = [ ./configuration.nix ];
}