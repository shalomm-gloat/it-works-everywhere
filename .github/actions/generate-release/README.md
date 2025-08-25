# Generate Release Action

This action generates release notes and creates GitHub releases for tagged versions.

## Purpose

Automates the release process by generating comprehensive release notes from commit history and creating formal GitHub releases with proper documentation.

## How it works

The action performs the complete release process:

1. **Release Notes Generation**: Creates detailed release notes from commits
2. **GitHub Release Creation**: Publishes the release on GitHub
3. **Summary Generation**: Provides release summary
4. **Documentation**: Includes security and quality information

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `tag-name` | Tag name for the release | Yes | - |

## Outputs

This action has no outputs - it creates the release directly on GitHub.

## Usage

```yaml
- name: Generate release
  uses: ./.github/actions/generate-release
  with:
    tag-name: ${{ github.ref_name }}
```

## Release Process

### 1. Release Notes Generation
The action generates comprehensive release notes including:

- **Release Header**: Version and release title
- **What's New**: List of commits since last release
- **Security**: Vulnerability scanning information
- **Quality**: Code quality and testing information

### 2. GitHub Release Creation
Creates a formal GitHub release with:

- **Release Name**: `Release v1.0.0`
- **Tag Name**: The version tag (e.g., `v1.0.0`)
- **Release Notes**: Auto-generated from commits
- **Draft Status**: `false` (published immediately)
- **Pre-release Status**: `false` (production release)

## Release Notes Format

```markdown
## 🚀 Release v1.0.0

### 📦 What's New

- feat: Add new feature
- fix: Fix critical bug
- docs: Update documentation
- chore: Update dependencies

### 🔒 Security

- Vulnerability scanning completed
- Container image built and pushed

### 📊 Quality

- All tests passing
- Code quality gates passed
```

## Commit History

The action extracts commits since the last release:

- **Range**: From previous tag to current tag
- **Format**: One-line commit messages
- **Filtering**: Includes all commit types (feat, fix, docs, etc.)

## Release Summary

The action generates a summary with:

- **Release Version**: The tag being released
- **Status**: Success/failure status
- **Timestamp**: Release creation time
- **Artifacts**: Generated release notes

## Best Practices

1. **Semantic Commits**: Use conventional commit format for better release notes
2. **Regular Releases**: Create releases for all significant versions
3. **Security Scanning**: Include security information in releases
4. **Quality Gates**: Ensure all quality checks pass before release
5. **Documentation**: Include comprehensive release notes

## Dependencies

- Git tag information
- GitHub API access
- Commit history
- Release configuration
