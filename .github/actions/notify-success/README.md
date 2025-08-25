# Notify Success Action

This action sends success notifications for successful deployments across different channels.

## Purpose

Provides comprehensive notification coverage for successful deployments, including GitHub comments, email notifications, and logging for audit trails.

## How it works

The action sends notifications through multiple channels:

1. **GitHub Comments**: Creates comments on pull requests
2. **Email Notifications**: Sends success emails to stakeholders
3. **Logging**: Provides detailed logs for monitoring
4. **Summary**: Creates deployment summary

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `environment` | Environment that was deployed | Yes | - |
| `registry` | Docker registry URL | Yes | - |
| `image-name` | Docker image name | Yes | - |
| `version` | Version that was deployed | Yes | - |
| `brevo-smtp-user` | Brevo SMTP username | Yes | - |
| `brevo-smtp-key` | Brevo SMTP password | Yes | - |

## Outputs

This action has no outputs - it sends notifications directly.

## Usage

```yaml
- name: Notify success
  if: success()
  uses: ./.github/actions/notify-success
  with:
    environment: ${{ steps.env.outputs.environment }}
    registry: ${{ env.REGISTRY }}
    image-name: ${{ env.IMAGE_NAME }}
    version: ${{ steps.version.outputs.version }}
    brevo-smtp-user: ${{ secrets.BREVO_SMTP_USER }}
    brevo-smtp-key: ${{ secrets.BREVO_SMTP_KEY }}
```

## Notification Channels

### GitHub Comments
- **Target**: Pull request comments
- **Content**: Deployment success details
- **Trigger**: Only for pull request events
- **Format**: Markdown with deployment information

### Email Notifications
- **Provider**: Brevo (formerly Sendinblue)
- **Recipients**: Deployment actor
- **Subject**: Environment-specific success message
- **Content**: Detailed deployment information with URLs

### Logging
- **Console Output**: Detailed deployment logs
- **Audit Trail**: Complete deployment history
- **Debugging**: Error handling and troubleshooting

## Notification Content

### GitHub Comment
```
✅ **Production Deployment Successful**

**Repository**: owner/repo
**Branch**: main
**Version**: v1.0.0+abc123.20240825.145920
**Commit**: abc1234
**Triggered by**: username
**Image**: docker.io/myapp:v1.0.0+abc123.20240825.145920

🎉 All checks passed and production deployment completed successfully!
```

### Email Notification
- **Subject**: `✅ Production Deployment Successful - owner/repo`
- **Body**: Detailed deployment information with environment URLs
- **Format**: Markdown with deployment details

## Environment URLs

Each environment has a specific URL included in notifications:

- **Development**: `https://mydev.getthemilkshake.com`
- **Staging**: `https://mystaging.getthemilkshake.com`
- **Production**: `https://myprod.getthemilkshake.com`

## Best Practices

1. **Multi-channel Notifications**: Ensure notifications reach all stakeholders
2. **Rich Information**: Include all relevant deployment details
3. **Environment-specific**: Tailor messages to deployment environment
4. **Error Handling**: Graceful handling of notification failures
5. **Audit Trail**: Complete logging for compliance

## Dependencies

- GitHub API access (for comments)
- Brevo SMTP credentials
- Deployment information from previous steps
- Environment configuration
