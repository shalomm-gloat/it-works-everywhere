# Validate Version Action

Validates that a specific version exists and checks out that version.

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `version` | Version to validate and checkout | Yes | - |

## Usage

```yaml
- name: Validate and checkout version
  uses: ./.github/actions/validate-version
  with:
    version: ${{ github.event.inputs.version }}
```

## Validation Process

1. **Check if version exists** as a Git tag
2. **Show available versions** if requested version not found
3. **Checkout the version** if validation passes

## Error Handling

- Clear error messages with available versions
- Validation of version format
- Handling of Git checkout failures

## Use Cases

### Rollback Scenarios
```yaml
- name: Validate rollback version
  uses: ./.github/actions/validate-version
  with:
    version: v1.0.0
```

### Release Deployment
```yaml
- name: Validate release version
  uses: ./.github/actions/validate-version
  with:
    version: v2.0.0
```
