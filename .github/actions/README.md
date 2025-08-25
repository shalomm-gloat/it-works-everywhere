# GitHub Actions Overview

This directory contains reusable GitHub Actions that break down the CI/CD pipeline into modular components.

## Core Actions

### `generate-version/`
- **Purpose**: Generate semantic version tags based on branch
- **Outputs**: version, base_version, version_suffix, env_suffix
- **Usage**: Used in CI workflow for versioning

### `get-environment/`
- **Purpose**: Determine target environment based on branch
- **Outputs**: environment
- **Usage**: Used in CI workflow for environment mapping

### `deploy/`
- **Purpose**: Platform-agnostic application deployment
- **Platforms**: AWS ECS, simulated
- **Outputs**: deployment-status, deployment-url, deployment-duration
- **Usage**: Used in CI workflow for deployment

## Notification Actions

### `notify-success/`
- **Purpose**: Send success notifications for deployments
- **Features**: GitHub comments, email notifications
- **Usage**: Used in CI workflow on successful deployments

### `notify-failure/`
- **Purpose**: Send failure notifications for deployments
- **Features**: GitHub issues, email notifications
- **Usage**: Used in CI workflow on failed deployments

## Rollback Actions

### `validate-version/`
- **Purpose**: Validate version exists and checkout specific version
- **Usage**: Used in rollback workflow

### `rollback-deploy/`
- **Purpose**: Deploy rollback version and perform health checks
- **Usage**: Used in rollback workflow

### `create-rollback-issue/`
- **Purpose**: Create GitHub issue for rollback tracking
- **Usage**: Used in rollback workflow

## Release Actions

### `generate-release/`
- **Purpose**: Generate release notes and create GitHub releases
- **Usage**: Used in release workflow

## Benefits

- **Modularity**: Each action has a single responsibility
- **Reusability**: Actions can be used across multiple workflows
- **Maintainability**: Changes only need to be made in one place
- **Testability**: Individual actions can be tested independently

## Usage Example

```yaml
- name: Generate version
  uses: ./.github/actions/generate-version

- name: Deploy application
  uses: ./.github/actions/deploy
  with:
    environment: production
    image: docker.io/myapp:v1.0.0
    version: v1.0.0
    platform: simulated
```

## Best Practices

- **Input Validation**: All actions validate their inputs
- **Error Handling**: Actions handle errors gracefully
- **Documentation**: Each action has clear description and usage examples
- **Security**: Sensitive operations use GitHub secrets
