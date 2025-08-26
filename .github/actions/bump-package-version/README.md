# Bump Package Version Action

Updates package.json version and commits the changes back to the repository.

## Features

- **Version Update**: Updates package.json with new version
- **Git Operations**: Commits and pushes changes automatically
- **Branch Aware**: Handles both PRs and direct pushes correctly
- **Skip CI**: Prevents triggering new workflow runs

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `new-version` | New version to set in package.json | ✅ | - |
| `github-token` | GitHub token for pushing changes | ✅ | - |

## Outputs

None

## Usage

```yaml
- name: Bump package version
  if: needs.versioning.outputs.should-bump == 'true'
  uses: ./.github/actions/bump-package-version
  with:
    new-version: ${{ needs.versioning.outputs.new-version }}
    github-token: ${{ github.token }}
```

## Behavior

- **Updates package.json** with the new version
- **Commits changes** with message "chore: bump version to X.X.X [skip ci]"
- **Pushes to correct branch**:
  - PR events: pushes to PR source branch
  - Direct pushes: pushes to target branch
- **Skips CI** to prevent infinite loops

## Dependencies

- Node.js (for JSON manipulation)
- Git (for commit/push operations)
