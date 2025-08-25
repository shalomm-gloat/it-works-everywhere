# Validate Version Action

This action validates that a specific version exists and checks out that version for deployment.

## Purpose

Ensures version integrity by validating that a requested version exists in the repository before attempting to deploy it, preventing deployment of non-existent versions.

## How it works

The action performs version validation and checkout:

1. **Version Validation**: Checks if the specified version exists as a Git tag
2. **Error Reporting**: Provides detailed error information if version doesn't exist
3. **Version Checkout**: Switches to the specified version
4. **Summary**: Reports validation results

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `version` | Version to validate and checkout | Yes | - |

## Outputs

This action has no outputs - it validates and checks out the version directly.

## Usage

```yaml
- name: Validate and checkout version
  uses: ./.github/actions/validate-version
  with:
    version: ${{ github.event.inputs.version }}
```

## Validation Process

### 1. Version Existence Check
The action verifies that the specified version exists:

- **Git Tags**: Checks if the version exists as a Git tag
- **Format Validation**: Ensures proper version format
- **Error Handling**: Provides clear error messages

### 2. Available Versions
If the version doesn't exist, the action shows available versions:

```bash
❌ Version v1.0.0 not found
Available versions:
v0.1.0
v0.2.0
v0.3.0
v1.0.0-dev
v1.0.0-stg
```

### 3. Version Checkout
Once validated, the action checks out the specified version:

- **Git Checkout**: Switches to the specified tag
- **Working Directory**: Updates the working directory
- **Confirmation**: Reports successful checkout

## Error Handling

The action provides comprehensive error handling:

- **Missing Version**: Clear error message with available versions
- **Invalid Format**: Validation of version format
- **Git Errors**: Handling of Git checkout failures
- **Permission Issues**: Handling of repository access issues

## Use Cases

### Rollback Scenarios
```yaml
# Rollback to a specific version
- name: Validate rollback version
  uses: ./.github/actions/validate-version
  with:
    version: v1.0.0
```

### Release Deployment
```yaml
# Deploy a specific release version
- name: Validate release version
  uses: ./.github/actions/validate-version
  with:
    version: v2.0.0
```

### Hotfix Deployment
```yaml
# Deploy a hotfix version
- name: Validate hotfix version
  uses: ./.github/actions/validate-version
  with:
    version: v1.0.1-hotfix
```

## Best Practices

1. **Version Validation**: Always validate versions before deployment
2. **Error Reporting**: Provide clear error messages with available options
3. **Rollback Safety**: Ensure rollback versions exist before attempting rollback
4. **Version Tracking**: Keep track of all deployed versions
5. **Documentation**: Document version naming conventions

## Dependencies

- Git repository access
- Version tag information
- Repository permissions
