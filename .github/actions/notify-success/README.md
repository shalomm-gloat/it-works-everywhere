# Notify Success Action

Sends success notifications via email and GitHub comments when deployments complete successfully.

## Features

- **Email Notifications**: Uses Brevo SMTP for reliable email delivery
- **GitHub Comments**: Creates comments on PRs for tracking
- **Environment-Aware**: Displays environment-specific information
- **Rich Formatting**: Uses Markdown for better readability

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `environment` | Deployment environment (e.g., development, staging, production) | ✅ | - |
| `registry` | Docker registry URL | ✅ | - |
| `image-name` | Docker image name | ✅ | - |
| `version` | Deployed version tag | ✅ | - |
| `brevo-smtp-user` | Brevo SMTP username | ✅ | - |
| `brevo-smtp-key` | Brevo SMTP password | ✅ | - |
| `github-token` | GitHub token for API access | ✅ | - |

## Outputs

None

## Usage

```yaml
- name: Notify success
  uses: ./.github/actions/notify-success
  with:
    environment: ${{ env.DEPLOYMENT_ENV }}
    registry: ${{ env.REGISTRY }}
    image-name: ${{ env.IMAGE_NAME }}
    version: ${{ steps.version.outputs.version }}
    brevo-smtp-user: ${{ secrets.BREVO_SMTP_USER }}
    brevo-smtp-key: ${{ secrets.BREVO_SMTP_KEY }}
    github-token: ${{ secrets.GH_AUTH_TOKEN }}
```

## Behavior

- **PR Events**: Creates a comment on the PR with deployment details
- **Direct Pushes**: Logs notification without creating comments
- **Email**: Sends notification to configured recipients
- **Error Handling**: Gracefully handles permission issues

## Dependencies

- `actions/github-script@v6` - For GitHub API interactions
- `dawidd6/action-send-mail@v6` - For email notifications
