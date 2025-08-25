# Deploy Action

## Overview

The `deploy` action provides platform-agnostic application deployment with support for AWS ECS and simulated deployments. It handles deployment execution, timing, and provides essential logging and outputs.

## Purpose

- **Platform Agnostic**: Single action for AWS ECS and simulated deployments
- **Extensible**: Easy to add new platform integrations
- **Observable**: Essential logging and deployment metrics
- **Reusable**: Can be used across different workflows and environments

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `environment` | Target deployment environment | ✅ | - |
| `image` | Full Docker image name with tag | ✅ | - |
| `version` | Application version being deployed | ✅ | - |
| `platform` | Deployment platform | ❌ | `simulated` |

### Platform Options

- **`simulated`**: Demo mode with environment-specific URLs
- **`aws-ecs`**: AWS ECS deployment (uses GitHub Actions ready approach)

## Outputs

| Output | Description |
|--------|-------------|
| `deployment-status` | Deployment status (success/failed) |
| `deployment-url` | Deployment URL (if available) |
| `deployment-duration` | Deployment duration in seconds |

## Usage

### Basic Usage (Simulated)

```yaml
- name: Deploy application
  uses: ./.github/actions/deploy
  with:
    environment: production
    image: docker.io/myuser/myapp:v1.0.0
    version: v1.0.0
    platform: simulated
```

### AWS ECS Deployment

```yaml
- name: Deploy to ECS
  uses: ./.github/actions/deploy
  with:
    environment: production
    image: docker.io/myuser/myapp:v1.0.0
    version: v1.0.0
    platform: aws-ecs
```

## Features

### 1. Platform Extensibility

The action uses a case statement to handle different platforms:

```bash
case "${{ inputs.platform }}" in
  "aws-ecs")
    # AWS ECS deployment logic (GitHub Actions ready)
    ;;
  "simulated"|*)
    # Default simulated deployment
    ;;
esac
```

### 2. Deployment Timing

Records deployment start and end times to calculate duration:

```bash
START_TIME=$(date +%s)
# ... deployment logic ...
END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))
```

### 3. Environment-Specific URLs

For simulated deployments, generates appropriate URLs:

- **Production**: `https://myprod.getthemilkshake.com`
- **Staging**: `https://mystaging.getthemilkshake.com`
- **Development**: `https://mydev.getthemilkshake.com`

### 4. GitHub Step Summary

Creates a comprehensive deployment summary visible in the GitHub Actions UI with:
- Deployment details
- Timing information
- Rollback instructions

## Extending for New Platforms

To add a new platform:

1. **Add platform case** in the deployment logic
2. **Implement platform-specific commands**
3. **Set appropriate deployment URL**
4. **Update documentation**

Example for a new platform:

```bash
"new-platform")
  echo "🚀 Deploying to New Platform..."
  # new-platform-specific commands here
  echo "✅ New Platform deployment completed"
  DEPLOYMENT_URL="https://new-platform.${{ inputs.environment }}.example.com"
  ;;
```

**Note**: The action is designed to be GitHub Actions ready, using official actions where possible.

## Integration with CI/CD

This action is designed to work seamlessly with the main CI/CD pipeline:

- **Inputs**: Receives environment, image, and version from previous steps
- **Outputs**: Provides deployment status for notification actions
- **Logging**: Comprehensive logging for debugging and monitoring

## Best Practices

1. **Platform Selection**: Choose the appropriate platform for your deployment target
2. **Error Handling**: The action includes basic error handling and status reporting
3. **Monitoring**: Use the deployment duration output for performance monitoring
4. **Rollback**: The action provides rollback information in the step summary

## Future Enhancements

- **Health Checks**: Post-deployment health verification
- **Rollback Integration**: Automatic rollback on deployment failure
- **Blue-Green Deployments**: Support for zero-downtime deployments
- **Canary Deployments**: Gradual traffic shifting
- **Multi-Region**: Support for multi-region deployments
- **Additional Platforms**: Kubernetes, Azure, GCP (as needed)

## Terminology

### Deployment Concepts

| Term | Definition |
|------|------------|
| **Deployment** | The process of releasing a new version of an application to a target environment |
| **Environment** | A specific deployment target (development, staging, production) |
| **Platform** | The infrastructure technology used for deployment (AWS ECS, Kubernetes, etc.) |
| **Image** | A Docker container image containing the application code and dependencies |
| **Version** | A unique identifier for a specific release of the application |
| **Rollback** | The process of reverting to a previous version if deployment fails |

### AWS ECS Terms

| Term | Definition |
|------|------------|
| **ECS** | Amazon Elastic Container Service - AWS container orchestration service |
| **Cluster** | A logical grouping of ECS tasks and services |
| **Service** | A long-running task definition that maintains a desired number of running tasks |
| **Task** | An instance of a task definition running in a cluster |
| **Task Definition** | A blueprint for your application that describes container specifications |

### GitHub Actions Terms

| Term | Definition |
|------|------------|
| **Action** | A reusable unit of code that can be used in workflows |
| **Workflow** | A configurable automated process made up of one or more jobs |
| **Job** | A set of steps that execute on the same runner |
| **Step** | An individual task that can run commands or use actions |
| **Runner** | A server that runs your workflows when they're triggered |
| **Composite Action** | An action that combines multiple steps into a reusable unit |

### Deployment Strategies

| Term | Definition |
|------|------------|
| **Simulated Deployment** | A mock deployment for testing and demonstration purposes |
| **Blue-Green Deployment** | A deployment strategy that maintains two identical production environments |
| **Canary Deployment** | A deployment strategy that gradually shifts traffic to a new version |
| **Rolling Deployment** | A deployment strategy that updates instances one at a time |
| **Zero-Downtime Deployment** | A deployment that doesn't interrupt service availability |

### Environment Types

| Term | Definition |
|------|------------|
| **Development** | Environment for active development and testing |
| **Staging** | Environment that mirrors production for final testing |
| **Production** | Live environment serving real users |
| **Pre-production** | Environment for final validation before production |

### Quick Reference

#### Common Deployment Commands
```bash
# AWS ECS deployment
aws ecs update-service --cluster my-cluster --service my-service --force-new-deployment

# Docker image tagging
docker tag myapp:latest myapp:v1.0.0

# Health check
curl -f http://localhost:3000/health
```

#### Environment URLs
- **Production**: `https://myprod.getthemilkshake.com`
- **Staging**: `https://mystaging.getthemilkshake.com`
- **Development**: `https://mydev.getthemilkshake.com`

#### Version Format
- **Production**: `v1.0.0` (clean version)
- **Staging**: `v1.0.0-stg` (with suffix)
- **Development**: `v1.0.0-dev` (with suffix)
