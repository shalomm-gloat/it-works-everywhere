# Generate Version Action

Generates semantic version tags based on branch and package.json.

## Branch-based Versioning

| Branch | Version Format | Example |
|--------|---------------|---------|
| `main` | `v{version}` | `v1.0.0` |
| `develop` | `v{version}-dev` | `v1.0.0-dev` |
| `staging` | `v{version}-stg` | `v1.0.0-stg` |
| `release/*` | `v{version}-rc.{number}` | `v1.0.0-rc.1` |
| `hotfix/*` | `v{version}-hotfix` | `v1.0.0-hotfix` |
| `feature/*` | `v{version}-dev` | `v1.0.0-dev` |

## Outputs

| Output | Description | Example |
|--------|-------------|---------|
| `version` | Clean version string | `v1.0.0-dev` |
| `base_version` | Version from package.json | `1.0.0` |
| `version_suffix` | Pre-release suffix | `-dev` |
| `env_suffix` | Environment identifier | `dev` |
| `version_type` | Version classification | `pre-release` |
| `commit_sha` | Short commit SHA | `abc123` |
| `build_date` | Build timestamp | `20240825.145920` |

## Usage

```yaml
- name: Generate version tag
  id: version
  uses: ./.github/actions/generate-version

- name: Use version
  run: echo "Version: ${{ steps.version.outputs.version }}"
```
