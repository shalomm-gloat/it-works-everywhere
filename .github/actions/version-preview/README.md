# Version Preview Action

Shows version preview for PRs without making any changes to the repository.

## Features

- **Version Preview**: Shows what version bump will happen on merge
- **PR Only**: Designed specifically for pull request workflows
- **No Changes**: Only displays information, doesn't modify files
- **Clear Output**: Markdown formatted preview in workflow logs

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `github-token` | GitHub token for API access | ✅ | - |

## Outputs

None

## Usage

```yaml
- name: Version Preview
  uses: ./.github/actions/version-preview
  with:
    github-token: ${{ github.token }}
```

## Behavior

- **Gets current version** from package.json
- **Calculates preview version** using patch bump (default for main/staging)
- **Displays preview** showing what will happen on merge
- **No file changes** are made

## Preview Output

The action outputs a markdown formatted preview:

```markdown
## 📋 Version Preview

**Current Version:** 1.0.0
**Preview Version:** 1.0.1
**Bump Type:** patch (default for main/staging)

### What will happen on merge:
- Package.json version will be updated to **1.0.1**
- Docker image will be tagged as **v1.0.1-prod**
- Changes will be committed and pushed to main

> 💡 This is a preview only. No changes will be made to this PR.
```

## Dependencies

- Node.js (for JSON parsing)
- semver (for version calculation)
