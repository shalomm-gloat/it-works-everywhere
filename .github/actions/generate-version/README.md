# Generate Version Action

This action generates clean version tags based on the current branch and the version specified in `package.json`.

## How it works

The action creates clean, simple version tags based on the current branch:

### **Branch-based Versioning**:
- **main branch**: Release version (e.g., `v1.0.0`)
- **develop branch**: Development pre-release (e.g., `v1.0.0-dev`)
- **staging branch**: Staging pre-release (e.g., `v1.0.0-stg`)
- **release/* branches**: Release candidates (e.g., `v1.0.0-rc.1`)
- **hotfix/* branches**: Hotfix pre-release (e.g., `v1.0.0-hotfix`)
- **feature branches**: Development pre-release (e.g., `v1.0.0-dev`)

### **Clean Versioning**:
- **MAJOR.MINOR.PATCH**: From `package.json`
- **Pre-release**: Environment-specific suffixes (`-dev`, `-stg`, `-rc.1`, `-hotfix`)
- **Simple format**: No build metadata, just clean version numbers

## Outputs

- `version`: Clean version string (e.g., `v1.0.0-dev`)
- `base_version`: Base version from package.json (e.g., `1.0.0`)
- `version_suffix`: Pre-release suffix (e.g., `-dev`, `-stg`, `-rc.1`, `-hotfix`, or empty)
- `env_suffix`: Environment identifier (e.g., `dev`, `stg`, `rc`, `hotfix`, `prod`)
- `version_type`: Version classification (e.g., `pre-release`, `release-candidate`, `release`)
- `commit_sha`: Short commit SHA (e.g., `abc123`)
- `build_date`: Build timestamp (e.g., `20240825.145920`)

## Usage

```yaml
- name: Generate version tag
  id: version
  uses: ./.github/actions/generate-version

- name: Use version
  run: echo "Version: ${{ steps.version.outputs.version }}"
```

## Version Format

Creates clean, simple version tags:
- **Release**: `v{MAJOR}.{MINOR}.{PATCH}`
- **Pre-release**: `v{MAJOR}.{MINOR}.{PATCH}{PRERELEASE}`

### Examples:
- **Production**: `v1.0.0`
- **Development**: `v1.0.0-dev`
- **Staging**: `v1.0.0-stg`
- **Release Candidate**: `v1.0.0-rc.1`
- **Hotfix**: `v1.0.0-hotfix`
