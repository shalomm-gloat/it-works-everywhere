# Rollback Deploy Action

This action deploys a rollback version and performs health checks to ensure the rollback is successful.

## Purpose

Handles emergency rollback deployments by deploying a previous version and validating that the rollback resolves the issues that triggered it.

## How it works

The action performs a complete rollback process:

1. **Rollback Deployment**: Deploys the specified rollback version
2. **Health Validation**: Performs health checks on the rollback deployment
3. **Status Reporting**: Provides rollback status and summary
4. **Documentation**: Creates rollback documentation

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `version` | Version to rollback to | Yes | - |
| `environment` | Environment to rollback | Yes | - |
| `reason` | Reason for rollback | Yes | - |
| `registry` | Docker registry URL | Yes | - |
| `image-name` | Docker image name | Yes | - |

## Outputs

This action has no outputs - it performs the rollback directly.

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

### 1. Rollback Deployment
The action deploys the rollback version:

- **Version Selection**: Uses the specified rollback version
- **Environment Targeting**: Deploys to the specified environment
- **Image Tagging**: Uses `-rollback` suffix for rollback images
- **Deployment Method**: Uses appropriate deployment strategy

### 2. Health Check Validation
After deployment, performs comprehensive health checks:

- **Endpoint Validation**: Checks if the application responds
- **Health Endpoint**: Validates `/health` endpoint
- **Response Time**: Ensures acceptable performance
- **Error Rate**: Monitors for rollback issues

### 3. Status Reporting
Provides detailed rollback status:

- **Rollback Version**: The version that was rolled back to
- **Environment**: Target environment
- **Reason**: Why the rollback was performed
- **Status**: Success/failure status
- **Health**: Application health status

## Rollback Summary

The action generates a comprehensive summary:

```markdown
## 🔄 Rollback Complete

- **Version**: v1.0.0
- **Environment**: production
- **Reason**: Health check failures
- **Status**: ✅ Success
- **Health**: ✅ Passed
- **Image**: docker.io/myapp:v1.0.0-rollback
```

## Use Cases

### Emergency Rollback
```yaml
# Emergency rollback due to critical issues
- name: Emergency rollback
  uses: ./.github/actions/rollback-deploy
  with:
    version: v1.0.0
    environment: production
    reason: "Critical security vulnerability detected"
```

### Performance Rollback
```yaml
# Rollback due to performance issues
- name: Performance rollback
  uses: ./.github/actions/rollback-deploy
  with:
    version: v1.0.0
    environment: production
    reason: "Performance degradation detected"
```

## Best Practices

1. **Quick Response**: Rollbacks should be fast and reliable
2. **Health Validation**: Always verify rollback success
3. **Documentation**: Document rollback reasons and outcomes
4. **Monitoring**: Monitor rollback deployments closely
5. **Communication**: Notify stakeholders of rollback status

## Dependencies

- Valid rollback version
- Environment configuration
- Health check endpoints
- Deployment credentials
