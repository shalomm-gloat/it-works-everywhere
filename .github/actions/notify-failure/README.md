# Notify Failure Action

Sends failure notifications for deployment failures.

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `environment` | Environment that failed deployment | Yes | - |
| `version` | Version that failed to deploy | No | `N/A` |
| `brevo-smtp-user` | Brevo SMTP username | Yes | - |
| `brevo-smtp-key` | Brevo SMTP password | Yes | - |

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
- Creates detailed failure tracking issues
- Includes failure information and next steps
- Requires issue creation permissions

### Email Notifications
- Sends failure alerts via Brevo SMTP
- Includes failure details and log links

## Error Handling

- Graceful handling when GitHub permissions are insufficient
- Continues execution even if email fails
- Uses `N/A` for missing information
