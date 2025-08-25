# Rollback Deploy Action

Deploys a rollback version and performs health checks.

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `version` | Version to rollback to | Yes | - |
| `environment` | Environment to rollback | Yes | - |
| `reason` | Reason for rollback | Yes | - |
| `registry` | Docker registry URL | Yes | - |
| `image-name` | Docker image name | Yes | - |

## Usage

```yaml
- name: Deploy rollback
  uses: ./.github/actions/rollback-deploy
  with:
    version: ${{ github.event.inputs.version }}
    environment: ${{ github.event.inputs.environment }}
    reason: ${{ github.event.inputs.reason }}
    registry: ${{ env.REGISTRY }}
    image-name: ${{ env.IMAGE_NAME }}
```

## Rollback Process

1. **Deploy rollback version** to specified environment
2. **Perform health checks** to validate rollback success
3. **Generate rollback summary** with status and details

## Use Cases

### Emergency Rollback
```yaml
- name: Emergency rollback
  uses: ./.github/actions/rollback-deploy
  with:
    version: v1.0.0
    environment: production
    reason: "Critical security vulnerability detected"
```

### Performance Rollback
```yaml
- name: Performance rollback
  uses: ./.github/actions/rollback-deploy
  with:
    version: v1.0.0
    environment: production
    reason: "Performance degradation detected"
```
