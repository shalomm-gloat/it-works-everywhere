# Generate Version Action

This action generates semantic version tags based on the current branch and the version specified in `package.json`.

## How it works

The action reads the base version from `package.json` and applies environment-specific suffixes based on the current branch:

- **main branch**: No suffix (e.g., `v1.0.0+abc123`)
- **develop branch**: `-dev` suffix (e.g., `v1.0.0-dev+abc123`)
- **staging branch**: `-stg` suffix (e.g., `v1.0.0-stg+abc123`)
- **other branches**: `-dev` suffix (e.g., `v1.0.0-dev+abc123`)

The commit SHA is added as build metadata for traceability.

## Outputs

- `version`: Full version string (e.g., `v1.0.0-dev+abc123`)
- `base_version`: Base version from package.json (e.g., `1.0.0`)
- `version_suffix`: Environment suffix (e.g., `-dev`, `-stg`, or empty)
- `env_suffix`: Environment identifier (e.g., `dev`, `stg`, or empty)
- `commit_sha`: Short commit SHA (e.g., `abc123`)

## Usage

```yaml
- name: Generate version tag
  id: version
  uses: ./.github/actions/generate-version

- name: Use version
  run: echo "Version: ${{ steps.version.outputs.version }}"
```

## Version Format

Follows [Semantic Versioning 2.0.0](https://semver.org/) with build metadata:
- `v{MAJOR}.{MINOR}.{PATCH}{PRERELEASE}+{BUILD}`
- Example: `v1.0.0-dev+abc123`
