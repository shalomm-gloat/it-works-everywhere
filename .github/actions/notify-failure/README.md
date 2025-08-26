# Notify Failure Action

Sends failure notifications via email and GitHub comments when deployments fail.

## Features

- **Email Notifications**: Uses Brevo SMTP for reliable email delivery
- **GitHub Comments**: Creates comments on PRs for tracking failures
- **Error Details**: Includes specific error information
- **Workflow Links**: Provides direct links to workflow logs

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `environment` | Deployment environment (e.g., development, staging, production) | ✅ | - |
| `version` | Deployed version tag | ✅ | - |
| `error` | Error message describing the failure | ✅ | - |
| `brevo-smtp-user` | Brevo SMTP username | ✅ | - |
| `brevo-smtp-key` | Brevo SMTP password | ✅ | - |
| `github-token` | GitHub token for API access | ✅ | - |

## Outputs

None

## Usage

```yaml
- name: Notify failure
  if: failure()
  uses: ./.github/actions/notify-failure
  with:
    environment: ${{ env.DEPLOYMENT_ENV }}
    version: ${{ steps.version.outputs.version }}
    error: 'Deployment failed - check workflow logs for details'
    brevo-smtp-user: ${{ secrets.BREVO_SMTP_USER }}
    brevo-smtp-key: ${{ secrets.BREVO_SMTP_KEY }}
    github-token: ${{ secrets.GH_AUTH_TOKEN }}
```

## Behavior

- **PR Events**: Creates a comment on the PR with failure details
- **Direct Pushes**: Logs notification without creating comments
- **Email**: Sends failure notification to configured recipients
- **Error Handling**: Gracefully handles permission issues

## Dependencies

- `actions/github-script@v6` - For GitHub API interactions
- `dawidd6/action-send-mail@v6` - For email notifications
