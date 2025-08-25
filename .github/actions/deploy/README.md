# Deploy Action

This action deploys the application to the specified environment using the built Docker image.

## Purpose

Handles the deployment process for different environments (development, staging, production) with environment-specific configurations and validations.

## How it works

The action performs environment-specific deployment operations:

1. **Environment Detection**: Determines target environment
2. **Deployment Execution**: Deploys using the appropriate method
3. **Health Validation**: Verifies deployment success
4. **Summary Generation**: Creates deployment summary

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `environment` | Target environment to deploy to | Yes | - |

## Outputs

This action has no outputs - it deploys the application directly.

## Usage

```yaml
- name: Deploy application
  uses: ./.github/actions/deploy
  with:
    environment: ${{ steps.env.outputs.environment }}
```

## Environment Support

### Development
- **Purpose**: Feature testing and development
- **URL**: `https://mydev.getthemilkshake.com`
- **Deployment**: Quick deployment for testing

### Staging
- **Purpose**: Pre-production testing
- **URL**: `https://mystaging.getthemilkshake.com`
- **Deployment**: Production-like environment

### Production
- **Purpose**: Live application
- **URL**: `https://myprod.getthemilkshake.com`
- **Deployment**: Production deployment with full validation

## Deployment Methods

The action supports various deployment strategies:

- **Kubernetes**: `kubectl apply` for container orchestration
- **Docker Swarm**: `docker stack deploy` for swarm mode
- **AWS ECS**: `aws ecs update-service` for AWS deployments
- **Azure Container Instances**: `az container create` for Azure
- **Google Cloud Run**: `gcloud run deploy` for GCP

## Health Checks

After deployment, the action performs:

1. **Endpoint Validation**: Checks if the application responds
2. **Health Endpoint**: Validates `/health` endpoint
3. **Response Time**: Ensures acceptable performance
4. **Error Rate**: Monitors for deployment issues

## Deployment Summary

The action generates a summary with:

- **Environment**: Target deployment environment
- **Status**: Success/failure status
- **Timestamp**: Deployment time
- **Health**: Application health status

## Best Practices

1. **Environment Isolation**: Separate configurations per environment
2. **Health Validation**: Always verify deployment success
3. **Rollback Ready**: Ensure rollback capability
4. **Monitoring**: Include health checks and monitoring
5. **Security**: Use environment-specific secrets

## Dependencies

- Docker image from previous build step
- Environment-specific configuration
- Health check endpoints
- Deployment credentials (if required)
