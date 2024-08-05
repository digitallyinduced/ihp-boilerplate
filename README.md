# IHP Boilerplate

This repository contains a boilerplate for IHP (Integrated Haskell Platform) projects with GitHub Actions for testing and deployment, used by `ihp-new`, see the [Installation Guide](https://ihp.digitallyinduced.com/Guide/installation.html).

## GitHub Actions Workflow

The repository includes a GitHub Actions workflow for automated testing and deployment. The workflow is defined in `.github/workflows/test.yml`.

### Workflow Triggers

The workflow is triggered on:
- Push to the `main` branch
- Pull requests to the `main` branch
- Manual trigger from the GitHub Actions tab

### Testing

The testing job performs the following steps:
1. Checks out the code
2. Sets up Nix
3. Initializes Cachix for faster builds
4. Installs and allows direnv
5. Builds generated files
6. Starts the project in the background
7. Runs the tests

### Deployment

To have the proper NixOS server up and running, follow the [Deployment Guide](https://ihp.digitallyinduced.com/Guide/deployment.html#deploying-with-deploytonixos) and create a proper virtual machine for your project.

The deployment job runs after successful tests and only for the `main` branch. It performs the following steps:
1. Checks out the code
2. Sets up SSH for deployment
3. Sets up Nix
4. Initializes Cachix
5. Sets up direnv
6. Deploys to a NixOS server

## Setup Instructions

To use this GitHub Actions workflow in your project:


1. Set up the following secrets in your GitHub [repository settings](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions):
    - `SSH_HOST`: The hostname or IP address of your deployment server
    - `SSH_USER`: The username for SSH access to the deployment server
    - `SSH_PRIVATE_KEY`: The private SSH key for authentication

1. Modify the `env` section in `.github/workflows/test.yml` if needed:
    - Update `PROJECT_NAME` to match your project
    - Adjust `ENV` if you want to use a different environment name
    - Update `NIXPKGS` if you want to use a different Nixpkgs version

1. Ensure your project has the necessary test files in the `Test` directory.

1. If your deployment process differs, modify the `deploy` job in the workflow file accordingly.

1Push your changes to the `main` branch to trigger the workflow.

## Manual Workflow Trigger

You can manually trigger the workflow from the Actions tab in your GitHub repository. This is useful for running tests or deploying without pushing changes.

## Customization

Feel free to customize the workflow file to fit your specific project needs. You may want to add additional steps, change the deployment process, or modify the testing procedure.

## Support

For issues related to this boilerplate or the GitHub Actions workflow, please open an issue in this repository.

For general IHP support, refer to the [IHP documentation](https://ihp.digitallyinduced.com/Guide/) or the [IHP Forum](https://ihp.digitallyinduced.com/community/).