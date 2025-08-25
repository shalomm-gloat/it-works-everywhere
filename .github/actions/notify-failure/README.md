# Notify Failure Action

This action sends failure notifications for deployment failures across multiple channels with comprehensive error reporting.

## Purpose

Provides immediate notification of deployment failures with detailed error information, helping teams quickly identify and resolve issues.

## How it works

The action sends failure notifications through multiple channels:

1. **GitHub Issues**: Creates detailed failure tracking issues
2. **Email Notifications**: Sends failure alerts to stakeholders
3. **Logging**: Provides comprehensive error logs
4. **Error Handling**: Graceful handling of notification failures

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `environment` | Environment that failed deployment | Yes | - |
| `version` | Version that failed to deploy | No | `N/A` |
| `brevo-smtp-user` | Brevo SMTP username | Yes | - |
| `brevo-smtp-key` | Brevo SMTP password | Yes | - |

## Outputs

This action has no outputs - it sends notifications directly.

## Usage

```yaml
- name: Notify failure
  if: failure()
  uses: ./.github/actions/notify-failure
  with:
    environment: ${{ steps.env.outputs.environment }}
    version: ${{ steps.version.outputs.version }}
    brevo-smtp-user: ${{ secrets.BREVO_SMTP_USER }}
    brevo-smtp-key: ${{ secrets.BREVO_SMTP_KEY }}
```

## Notification Channels

### GitHub Issues
- **Purpose**: Track deployment failures
- **Labels**: `deployment-failure`, `urgent`, `ci-cd`
- **Content**: Detailed failure information with next steps
- **Permissions**: Requires issue creation permissions

### Email Notifications
- **Provider**: Brevo (formerly Sendinblue)
- **Recipients**: Deployment actor
- **Subject**: Environment-specific failure message
- **Content**: Failure details with log links

### Logging
- **Console Output**: Detailed failure logs
- **Error Details**: Complete error information
- **Debugging**: Troubleshooting information

## Notification Content

### GitHub Issue
```
🚨 Production Deployment Failed - abc1234

## Production Deployment Failure

**Repository**: owner/repo
**Branch**: main
**Version**: v1.0.0+abc123.20240825.145920
**Commit**: abc1234567890
**Triggered by**: username
**Workflow**: CI/CD Pipeline
**Run ID**: 123456789

**Logs**: https://github.com/owner/repo/actions/runs/123456789

## Next Steps
- [ ] Investigate failure cause
- [ ] Fix issues in development
- [ ] Re-run deployment
- [ ] Consider rollback if needed
```

### Email Notification
- **Subject**: `❌ Production Deployment Failed - owner/repo`
- **Body**: Failure details with log links and next steps
- **Format**: Markdown with actionable information

## Error Handling

The action includes robust error handling:

- **Permission Failures**: Graceful handling when GitHub permissions are insufficient
- **Email Failures**: Continues execution even if email fails
- **Missing Data**: Handles cases where version or branch information is unavailable
- **Fallback Values**: Uses `N/A` for missing information

## Best Practices

1. **Immediate Notification**: Failures are reported immediately
2. **Rich Context**: Include all relevant failure information
3. **Actionable Information**: Provide clear next steps
4. **Error Resilience**: Handle notification failures gracefully
5. **Audit Trail**: Complete logging for compliance

## Dependencies

- GitHub API access (for issues)
- Brevo SMTP credentials
- Deployment information from previous steps
- Environment configuration
