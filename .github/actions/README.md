# Reusable GitHub Actions

This directory contains reusable GitHub Actions that break down the CI/CD pipeline into modular, maintainable components.

## Actions Overview

### Core Actions

#### `test-quality/`
- **Purpose**: Run all testing and quality gates
- **Steps**: Node.js setup, dependency installation, linting, testing, security audit, health checks
- **Usage**: Used in CI workflow for quality validation

#### `docker-build/`
- **Purpose**: Build and push Docker images to registry
- **Steps**: Docker Buildx setup, registry login, metadata extraction, build and push
- **Inputs**: registry, image-name, username, password
- **Usage**: Used in CI, release, and rollback workflows

#### `deploy/`
- **Purpose**: Deploy application to specified environment
- **Steps**: Environment-specific deployment, summary generation
- **Inputs**: environment
- **Usage**: Used in CI workflow for deployment

### Notification Actions

#### `notify-success/`
- **Purpose**: Send success notifications for deployments
- **Steps**: GitHub comments, email notifications (simulated)
- **Inputs**: environment, registry, image-name
- **Usage**: Used in CI workflow on successful deployments

#### `notify-failure/`
- **Purpose**: Send failure notifications for deployments
- **Steps**: GitHub issues, email notifications (simulated)
- **Inputs**: environment
- **Usage**: Used in CI workflow on failed deployments

### Utility Actions

#### `get-environment/`
- **Purpose**: Determine target environment based on branch or workflow dispatch
- **Outputs**: environment
- **Usage**: Used in CI workflow to dynamically determine deployment target

#### `generate-release/`
- **Purpose**: Generate release notes and create GitHub releases
- **Steps**: Release notes generation, GitHub release creation, summary
- **Inputs**: tag-name
- **Usage**: Used in release workflow

### Rollback Actions

#### `validate-version/`
- **Purpose**: Validate version exists and checkout specific version
- **Steps**: Version validation, git checkout
- **Inputs**: version
- **Usage**: Used in rollback workflow

#### `rollback-deploy/`
- **Purpose**: Deploy rollback version and perform health checks
- **Steps**: Rollback deployment, health checks, summary
- **Inputs**: version, environment, reason, registry, image-name
- **Usage**: Used in rollback workflow

#### `create-rollback-issue/`
- **Purpose**: Create GitHub issue for rollback tracking
- **Steps**: GitHub issue creation, rollback notification
- **Inputs**: version, environment, reason, registry, image-name
- **Usage**: Used in rollback workflow

## Benefits

1. **Modularity**: Each action has a single responsibility
2. **Reusability**: Actions can be used across multiple workflows
3. **Maintainability**: Changes to functionality only need to be made in one place
4. **Testability**: Individual actions can be tested independently
5. **Readability**: Workflows are cleaner and easier to understand

## Usage Example

```yaml
- name: Run tests and quality gates
  uses: ./.github/actions/test-quality

- name: Build and push Docker image
  uses: ./.github/actions/docker-build
  with:
    registry: docker.io
    image-name: myapp
    username: ${{ secrets.DOCKER_USERNAME }}
    password: ${{ secrets.DOCKER_PASSWORD }}
```

## Best Practices

1. **Input Validation**: All actions validate their inputs
2. **Error Handling**: Actions handle errors gracefully
3. **Documentation**: Each action has clear description and usage examples
4. **Consistency**: Actions follow consistent naming and structure patterns
5. **Security**: Sensitive operations are properly secured with secrets
