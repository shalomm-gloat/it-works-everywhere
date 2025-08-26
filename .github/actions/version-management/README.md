# Version Management Action

Detects PR labels and calculates new version based on semantic versioning.

## Features

- **PR Label Detection**: Automatically detects version labels on pull requests
- **Semantic Versioning**: Uses semver library for proper version calculation
- **Label Validation**: Ensures exactly one version label is present
- **Flexible Outputs**: Provides all version information for downstream jobs

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `github-token` | GitHub token for API access | Yes | - |

## Outputs

| Output | Description | Example |
|--------|-------------|---------|
| `release-type` | Type of release (major, minor, patch) | `minor` |
| `new-version` | New version after bump | `1.1.0` |
| `old-version` | Current version | `1.0.0` |
| `should-bump` | Whether version should be bumped | `true` |

## Supported Labels

- **`version:major`** → Major version bump (1.0.0 → 2.0.0)
- **`version:minor`** → Minor version bump (1.0.0 → 1.1.0)
- **`version:patch`** → Patch version bump (1.0.0 → 1.0.1)
- **No label** → No version bump (uses current version)

## Usage

```yaml
- name: Version Management
  id: version
  uses: ./.github/actions/version-management
  with:
    github-token: ${{ github.token }}
```

## Error Handling

- **Multiple labels**: Fails if more than one version label is found
- **No labels**: Gracefully handles PRs without version labels
- **Invalid labels**: Validates label format and content

## Integration

This action is designed to work with the main CI pipeline:
1. **Detects PR labels** and calculates new version
2. **Outputs version info** for build job
3. **Enables conditional version bumping** in deployment

## Benefits

- **Reusable**: Can be used in multiple workflows
- **Maintainable**: Centralized version logic
- **Robust**: Handles edge cases and validation
- **Clear**: Provides explicit outputs for downstream jobs
