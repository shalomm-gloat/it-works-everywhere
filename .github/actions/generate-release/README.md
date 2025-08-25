# Generate Release Action

Generates release notes and creates GitHub releases for tagged versions.

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `tag-name` | Tag name for the release | Yes | - |

## Usage

```yaml
- name: Generate release
  uses: ./.github/actions/generate-release
  with:
    tag-name: ${{ github.ref_name }}
```

## Release Process

1. **Generate release notes** from commit history
2. **Create GitHub release** with the generated notes
3. **Include security and quality information**

## Release Notes Format

```markdown
## 🚀 Release v1.0.0

### 📦 What's New
- feat: Add new feature
- fix: Fix critical bug
- docs: Update documentation

### 🔒 Security
- Vulnerability scanning completed
- Container image built and pushed

### 📊 Quality
- All tests passing
- Code quality gates passed
```

## Commit History

Extracts commits since the last release:
- **Range**: From previous tag to current tag
- **Format**: One-line commit messages
- **Filtering**: Includes all commit types (feat, fix, docs, etc.)
