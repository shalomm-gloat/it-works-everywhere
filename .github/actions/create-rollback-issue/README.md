# Create Rollback Issue Action

Creates GitHub issues to track rollback deployments.

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `version` | Version rolled back to | Yes | - |
| `environment` | Environment that was rolled back | Yes | - |
| `reason` | Reason for rollback | Yes | - |
| `registry` | Docker registry URL | Yes | - |
| `image-name` | Docker image name | Yes | - |

## Usage

```yaml
- name: Create rollback issue
  uses: ./.github/actions/create-rollback-issue
  with:
    version: ${{ github.event.inputs.version }}
    environment: ${{ github.event.inputs.environment }}
    reason: ${{ github.event.inputs.reason }}
    registry: ${{ env.REGISTRY }}
    image-name: ${{ env.IMAGE_NAME }}
```

## Issue Content

### Issue Title
```
🔄 Rollback to v1.0.0
```

### Issue Body
Includes:
- Rollback details (version, environment, reason)
- Next steps for investigation and resolution
- Rollback status and health check results

## Issue Labels

Automatically adds:
- `rollback`: Identifies rollback issues
- `urgent`: Marks as urgent for attention
- `ci-cd`: Categorizes as CI/CD related
- `production`: Indicates production environment

## Use Cases

### Emergency Rollback Tracking
```yaml
- name: Create rollback tracking issue
  uses: ./.github/actions/create-rollback-issue
  with:
    version: v1.0.0
    environment: production
    reason: "Critical security vulnerability detected"
```
