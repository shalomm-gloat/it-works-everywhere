# Bump Version Action

Automatically bumps version based on PR labels or manual input.

## How it Works

### PR Label-Based Version Bumping
Uses PR labels to determine version bump type:
- **`version:major`** → Major version bump (1.0.0 → 2.0.0)
- **`version:minor`** → Minor version bump (1.0.0 → 1.1.0)
- **`version:patch`** → Patch version bump (1.0.0 → 1.0.1)
- **No version label** → Default to patch bump

### Manual Version Bumping
Specify the bump type manually:
- **`patch`** - Bug fixes (1.0.0 → 1.0.1)
- **`minor`** - New features (1.0.0 → 1.1.0)
- **`major`** - Breaking changes (1.0.0 → 2.0.0)

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `bump-type` | Type of version bump | No | `auto` |

## Outputs

| Output | Description | Example |
|--------|-------------|---------|
| `new-version` | New version after bump | `1.1.0` |
| `bump-type` | Type of bump performed | `minor` |

## Usage

### PR Label-Based Bumping (Recommended)
```yaml
- name: Bump version
  uses: ./.github/actions/bump-version
```

### Manual Bumping
```yaml
- name: Bump version
  uses: ./.github/actions/bump-version
  with:
    bump-type: minor
```

## PR Labels

Add these labels to your pull requests:

### **Major Version Bump**
- **Label**: `version:major`
- **Use case**: Breaking changes, major refactoring
- **Example**: `version:major`

### **Minor Version Bump**
- **Label**: `version:minor`
- **Use case**: New features, enhancements
- **Example**: `version:minor`

### **Patch Version Bump**
- **Label**: `version:patch`
- **Use case**: Bug fixes, documentation updates
- **Example**: `version:patch`

## Version Flow

1. **Development**: `1.0.0-dev` → `1.1.0-dev` (after PR with `version:minor` label)
2. **Staging**: `1.1.0-stg` (after merge to staging)
3. **Production**: `1.1.0` (after merge to main)

## Benefits

- **Explicit control** - Clear version bump intent
- **PR-based workflow** - Integrates with code review process
- **Team collaboration** - Reviewers can see version impact
- **Flexible** - Can override with manual bump type
