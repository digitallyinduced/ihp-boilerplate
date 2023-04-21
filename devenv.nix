{ pkgs, inputs, config, ... }:

{
  imports = [
    "${inputs.ihp}/NixSupport/devenv.nix"
  ];

  # https://devenv.sh/packages/
  packages = [ ];

  ihp.enable = true;
  ihp.projectPath = ./.;

  # See full reference at https://devenv.sh/reference/options/
}
