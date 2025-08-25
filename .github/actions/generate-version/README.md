# Generate Version Action

This action generates semantic version tags based on the current branch and the version specified in `package.json`.

## How it works

The action implements **Semantic Versioning 2.0.0** compliant versioning based on the current branch:

### **Branch-based Versioning**:
- **main branch**: Release version (e.g., `v1.0.0+abc123.20240825.145920`)
- **develop branch**: Development pre-release (e.g., `v1.0.0-dev+abc123.20240825.145920`)
- **staging branch**: Staging pre-release (e.g., `v1.0.0-stg+abc123.20240825.145920`)
- **release/* branches**: Release candidates (e.g., `v1.0.0-rc.1+abc123.20240825.145920`)
- **hotfix/* branches**: Hotfix pre-release (e.g., `v1.0.0-hotfix+abc123.20240825.145920`)
- **feature branches**: Development pre-release (e.g., `v1.0.0-dev+abc123.20240825.145920`)

### **SemVer 2.0.0 Compliance**: https://semver.org/
- **MAJOR.MINOR.PATCH**: From `package.json`
- **Pre-release**: Environment-specific suffixes (`-dev`, `-stg`, `-rc.1`, `-hotfix`)
- **Build metadata**: Commit SHA + build timestamp for traceability

## Outputs

- `version`: Full SemVer version string (e.g., `v1.0.0-dev+abc123.20240825.145920`)
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

Follows [Semantic Versioning 2.0.0](https://semver.org/) with enhanced build metadata:
- **Release**: `v{MAJOR}.{MINOR}.{PATCH}+{COMMIT}.{TIMESTAMP}`
- **Pre-release**: `v{MAJOR}.{MINOR}.{PATCH}{PRERELEASE}+{COMMIT}.{TIMESTAMP}`

### Examples:
- **Production**: `v1.0.0+abc123.20240825.145920`
- **Development**: `v1.0.0-dev+abc123.20240825.145920`
- **Staging**: `v1.0.0-stg+abc123.20240825.145920`
- **Release Candidate**: `v1.0.0-rc.1+abc123.20240825.145920`
- **Hotfix**: `v1.0.0-hotfix+abc123.20240825.145920`
