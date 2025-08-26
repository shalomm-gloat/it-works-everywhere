# Version Management Action

Analyzes conventional commits and calculates new version based on semantic versioning.

## Features

- **Conventional Commit Analysis**: Automatically analyzes commit messages since last tag
- **Semantic Versioning**: Uses semver library for proper version calculation
- **Main Branch Only**: Version bumps only on production releases (main branch)
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

## Conventional Commit Types

- **`BREAKING CHANGE` or `major`** → Major version bump (1.0.0 → 2.0.0)
- **`feat:`** → Minor version bump (1.0.0 → 1.1.0)
- **`fix:`** → Patch version bump (1.0.0 → 1.0.1)
- **`docs:`, `chore:`, etc.** → No version bump (defaults to patch on main)

## Usage

```yaml
- name: Version Management
  id: version
  uses: ./.github/actions/version-management
  with:
    github-token: ${{ github.token }}
```

## Behavior

### **Main Branch (Production)**
- **Analyzes commits** since last tag using `git log`
- **Determines bump type** based on conventional commit messages
- **Bumps version** and sets `should-bump=true`
- **Creates GitHub tags** automatically

### **Other Branches (Develop/Staging)**
- **No version bump** - maintains same version
- **Sets `should-bump=false`**
- **Same version** flows through environments

## Error Handling

- **No conventional commits**: Defaults to patch bump on main
- **No commits since last tag**: Defaults to patch bump
- **Invalid commit format**: Gracefully handles non-conventional commits

## Integration

This action is designed to work with the main CI pipeline:
1. **Analyzes conventional commits** and calculates new version
2. **Outputs version info** for build job
3. **Enables conditional version bumping** in deployment

## Benefits

- **Industry Standard**: Uses conventional commits (widely adopted)
- **Automatic**: No manual intervention required
- **Maintainable**: Centralized version logic
- **Robust**: Handles edge cases and validation
- **Clear**: Provides explicit outputs for downstream jobs
