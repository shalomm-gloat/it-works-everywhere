# Get Environment Action

Determines target deployment environment based on branch or workflow dispatch.

## Environment Mapping

| Branch | Environment | Purpose |
|--------|-------------|---------|
| `main` | `production` | Live production deployment |
| `develop` | `development` | Development and integration testing |
| `staging` | `staging` | Staging environment |
| `hotfix/*` | `production` | Emergency hotfix deployment |
| `release/*` | `staging` | Release candidate testing |
| Other | `development` | Feature development |

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `workflow-dispatch-env` | Environment from manual workflow dispatch | No | - |

## Outputs

| Output | Description | Example |
|--------|-------------|---------|
| `environment` | Target deployment environment | `production`, `staging`, `development` |

## Usage

```yaml
- name: Get target environment
  id: env
  uses: ./.github/actions/get-environment
  with:
    workflow-dispatch-env: ${{ github.event.inputs.environment }}
```

## Environment URLs

- **Development**: `https://mydev.getthemilkshake.com`
- **Staging**: `https://mystaging.getthemilkshake.com`
- **Production**: `https://myprod.getthemilkshake.com`
