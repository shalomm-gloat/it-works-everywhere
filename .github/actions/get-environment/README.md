# Get Environment Action

This action determines the target deployment environment based on the current branch or workflow dispatch inputs.

## Purpose

Dynamically determines which environment to deploy to based on the Git branch or manual workflow dispatch, ensuring proper environment targeting.

## How it works

The action analyzes the current context to determine the target environment:

1. **Branch Analysis**: Checks the current Git branch
2. **Workflow Dispatch**: Handles manual environment selection
3. **Environment Mapping**: Maps branches to environments
4. **Output Generation**: Provides environment information

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

## Environment Mapping

### Branch-based Environments

| Branch | Environment | Purpose |
|--------|-------------|---------|
| `main` | `production` | Live production deployment |
| `develop` | `staging` | Pre-production testing |
| `staging` | `staging` | Staging environment |
| `hotfix/*` | `production` | Emergency hotfix deployment |
| `release/*` | `staging` | Release candidate testing |
| Other | `development` | Feature development |

### Manual Workflow Dispatch

When triggered manually, the action respects the user-selected environment:

- **development**: Development environment
- **staging**: Staging environment  
- **production**: Production environment

## Environment URLs

Each environment has a specific URL which are not real :) :

- **Development**: `https://mydev.getthemilkshake.com`
- **Staging**: `https://mystaging.getthemilkshake.com`
- **Production**: `https://myprod.getthemilkshake.com`

## Branch Protection

The action works with GitHub branch protection rules:

- **main**: Protected, requires PR approval
- **develop**: Protected, requires PR approval
- **staging**: Protected, requires PR approval
- **Feature branches**: Free to push, require PR to merge

## Best Practices

1. **Environment Isolation**: Clear separation between environments
2. **Branch Strategy**: Consistent branch-to-environment mapping
3. **Manual Override**: Allow manual environment selection
4. **Security**: Respect branch protection rules
5. **Traceability**: Clear environment identification

## Dependencies

- Git branch information
- Workflow dispatch inputs (if manual)
- Environment configuration
