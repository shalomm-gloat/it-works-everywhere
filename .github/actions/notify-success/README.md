# Notify Success Action

Sends success notifications for successful deployments.

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `environment` | Environment that was deployed | Yes | - |
| `registry` | Docker registry URL | Yes | - |
| `image-name` | Docker image name | Yes | - |
| `version` | Version that was deployed | Yes | - |
| `brevo-smtp-user` | Brevo SMTP username | Yes | - |
| `brevo-smtp-key` | Brevo SMTP password | Yes | - |

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
- Creates comments on pull requests with deployment details
- Only triggered for pull request events

### Email Notifications
- Sends success emails via Brevo SMTP
- Includes deployment details and environment URLs

## Environment URLs

- **Development**: `https://mydev.getthemilkshake.com`
- **Staging**: `https://mystaging.getthemilkshake.com`
- **Production**: `https://myprod.getthemilkshake.com`
