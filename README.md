# IHP Project

This is an IHP (Integrated Haskell Platform) project with GitHub Actions for testing and deployment. For more information about IHP, see the [IHP Documentation](https://ihp.digitallyinduced.com/Guide/).

## GitHub Actions Workflow

This project includes a GitHub Actions workflow for automated testing and deployment. The workflow is defined in `.github/workflows/test.yml`.

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

For deployment, follow the [IHP Deployment Guide](https://ihp.digitallyinduced.com/Guide/deployment.html#deploying-with-deploytonixos) to set up a proper NixOS server for your project.

The deployment job runs after successful tests and only for the `main` branch. It performs the following steps:
1. Checks out the code
2. Sets up SSH for deployment
3. Sets up Nix
4. Initializes Cachix
5. Sets up direnv
6. Deploys to a NixOS server

## Setup Instructions

To use the GitHub Actions workflow in this project:

1. Set up the following secrets in your GitHub [repository settings](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions):
   - `SSH_HOST`: The hostname or IP address of your deployment server
   - `SSH_USER`: The username for SSH access to the deployment server
   - `SSH_PRIVATE_KEY`: The private SSH key for authentication

2. Modify the `env` section in `.github/workflows/test.yml` if needed:
   - Update `PROJECT_NAME` to match your project
   - Adjust `ENV` if you want to use a different environment name
   - Update `NIXPKGS` if you want to use a different Nixpkgs version

3. Ensure your project has the necessary test files in the `Test` directory.

4. If your deployment process differs, modify the `deploy` job in the workflow file accordingly.

5. Push your changes to the `main` branch to trigger the workflow.

## Manual Workflow Trigger

You can manually trigger the workflow from the Actions tab in your GitHub repository. This is useful for running tests or deploying without pushing changes.

## Customization

Feel free to customize the workflow file to fit your specific project needs. You may want to add additional steps, change the deployment process, or modify the testing procedure.

## Support

For issues related to IHP or this project's setup, please refer to the [IHP documentation](https://ihp.digitallyinduced.com/Guide/) or seek help on the [IHP Forum](https://ihp.digitallyinduced.com/community/).

For project-specific issues, please open an issue in this repository.