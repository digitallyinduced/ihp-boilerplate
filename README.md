# IHP Project

This is an IHP (Integrated Haskell Platform) project with a GitHub Actions workflow for continuous integration. For more information about IHP, see the [IHP Documentation](https://ihp.digitallyinduced.com/Guide/).

## GitHub Actions Workflow

This project includes a GitHub Actions workflow that builds the project and runs its test suite via `nix flake check`. The workflow is defined in [`.github/workflows/nix-flake-check.yml`](.github/workflows/nix-flake-check.yml).

### Workflow Triggers

The `Test` workflow runs on:
- Push to the `master` (or `main`) branch
- Pull requests targeting the `master` (or `main`) branch

Both branch names are listed so the workflow works whether the default branch is `master` (as in this repository) or `main` (the default for new repositories created from this boilerplate).

### What the workflow does

The `test` job runs on `ubuntu-latest` and performs the following steps:
1. Checks out the code
2. Frees up disk space for large Nix builds ([nothing-but-nix](https://github.com/wimpysworld/nothing-but-nix))
3. Installs Nix using the [Determinate Nix installer](https://github.com/DeterminateSystems/nix-installer-action) with lazy trees enabled
4. Configures the [`digitallyinduced` Cachix cache](https://app.cachix.org/cache/digitallyinduced) for faster builds (pull only — `skipPush: true`)
5. Enables the [Magic Nix Cache](https://github.com/DeterminateSystems/magic-nix-cache-action)
6. Runs `nix flake check --impure -L`, which builds the project and runs the test suite

## Running the checks locally

You can run the same checks that CI runs:

```bash
nix flake check --impure
```

## Deployment

This boilerplate does not include an automated deployment job. To deploy your project, follow the [IHP Deployment Guide](https://ihp.digitallyinduced.com/Guide/deployment.html#deploying-with-deploytonixos) to set up a NixOS server.

## Support

For issues related to IHP or this project's setup, please refer to the [IHP documentation](https://ihp.digitallyinduced.com/Guide/) or seek help on the [IHP Forum](https://ihp.digitallyinduced.com/community/).

For project-specific issues, please open an issue in this repository.
