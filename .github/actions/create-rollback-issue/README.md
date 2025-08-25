# Create Rollback Issue Action

This action creates GitHub issues to track rollback deployments and ensure proper documentation and follow-up.

## Purpose

Creates comprehensive GitHub issues to document rollback deployments, track the reasons for rollbacks, and ensure proper follow-up actions are taken.

## How it works

The action creates detailed GitHub issues for rollback tracking:

1. **Issue Creation**: Creates a GitHub issue with rollback details
2. **Documentation**: Documents rollback reasons and context
3. **Tracking**: Provides tracking information for follow-up
4. **Notification**: Notifies relevant stakeholders

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `version` | Version rolled back to | Yes | - |
| `environment` | Environment that was rolled back | Yes | - |
| `reason` | Reason for rollback | Yes | - |
| `registry` | Docker registry URL | Yes | - |
| `image-name` | Docker image name | Yes | - |

## Outputs

This action has no outputs - it creates the issue directly on GitHub.

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
```markdown
## 🔄 Rollback Deployment

**Version**: v1.0.0
**Environment**: production
**Reason**: Health check failures
**Rollback Image**: docker.io/myapp:v1.0.0-rollback

## 📋 Rollback Details

- **Previous Version**: v1.1.0
- **Rollback Version**: v1.0.0
- **Environment**: production
- **Triggered by**: username
- **Timestamp**: 2024-08-25T14:59:20Z

## 🎯 Next Steps

- [ ] Investigate root cause of issues
- [ ] Fix problems in development environment
- [ ] Test fixes thoroughly
- [ ] Plan re-deployment strategy
- [ ] Update monitoring and alerting
- [ ] Document lessons learned

## 📊 Rollback Status

- **Status**: ✅ Successful
- **Health Check**: ✅ Passed
- **Deployment**: ✅ Completed
```

## Issue Labels

The action automatically adds relevant labels:

- `rollback`: Identifies rollback issues
- `urgent`: Marks as urgent for attention
- `ci-cd`: Categorizes as CI/CD related
- `production`: Indicates production environment

## Use Cases

### Emergency Rollback Tracking
```yaml
# Track emergency rollback
- name: Create rollback tracking issue
  uses: ./.github/actions/create-rollback-issue
  with:
    version: v1.0.0
    environment: production
    reason: "Critical security vulnerability detected"
```

### Performance Rollback Documentation
```yaml
# Document performance rollback
- name: Create performance rollback issue
  uses: ./.github/actions/create-rollback-issue
  with:
    version: v1.0.0
    environment: production
    reason: "Performance degradation detected"
```

## Best Practices

1. **Comprehensive Documentation**: Include all relevant rollback details
2. **Actionable Next Steps**: Provide clear follow-up actions
3. **Stakeholder Notification**: Ensure relevant teams are notified
4. **Root Cause Analysis**: Track investigation and resolution
5. **Lessons Learned**: Document insights for future improvements

## Dependencies

- GitHub API access
- Repository permissions
- Rollback information
- Environment configuration
