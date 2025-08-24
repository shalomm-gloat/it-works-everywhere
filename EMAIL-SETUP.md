# Email Notification Setup

This project uses the [Send email GitHub Action](https://github.com/marketplace/actions/send-email) to send real email notifications for deployment success and failures.

## 📧 Setup Instructions

### 1. Gmail App Password Setup

Since we're using Gmail SMTP, you need to create an App Password:

1. **Enable 2-Step Verification** (required for App passwords)
   - Go to [Google Account settings](https://myaccount.google.com/)
   - Navigate to Security → 2-Step Verification
   - Enable it if not already enabled

2. **Create App Password**
   - Go to [Google Account settings](https://myaccount.google.com/)
   - Navigate to Security → App passwords
   - Select "Mail" as the app
   - Copy the generated 16-character password

### 2. GitHub Secrets Configuration

Add these secrets to your GitHub repository:

1. Go to your repository → Settings → Secrets and variables → Actions
2. Add the following secrets:

```
MAIL_USERNAME: your-email@gmail.com
MAIL_PASSWORD: your-16-character-app-password
```

### 3. Email Configuration

The email notifications are configured to:
- **SMTP Server**: smtp.gmail.com
- **Port**: 587 (TLS)
- **Recipient**: shalommeoded@gmail.com
- **Features**: Markdown conversion, HTML formatting

## 📋 Email Types

### Success Emails
- **Trigger**: Successful deployments to any environment
- **Subject**: `✅ [Environment] Deployment Successful - [Repository]`
- **Content**: Deployment details, URLs, success confirmation

### Failure Emails
- **Trigger**: Failed deployments to any environment
- **Subject**: `❌ [Environment] Deployment Failed - [Repository]`
- **Content**: Failure details, logs link, troubleshooting steps

## 🔧 Customization

### Change Email Recipient
Edit the notification actions in `.github/actions/`:
```yaml
to: your-email@example.com
```

### Change SMTP Settings
For different email providers, update the SMTP settings:
```yaml
server_address: smtp.your-provider.com
server_port: 587  # or 465 for SSL
```

### Add Multiple Recipients
```yaml
to: email1@example.com,email2@example.com
```

## 🚨 Troubleshooting

### Gmail Issues
- Ensure 2-Step Verification is enabled
- Use App Password, not your regular password
- Check that "Less secure app access" is not needed (App passwords are more secure)

### SMTP Errors
- Verify server_address and port
- Check username/password in GitHub secrets
- Ensure firewall allows SMTP connections

### Permission Issues
- Verify GitHub secrets are properly set
- Check that the workflow has access to secrets

## 📊 Benefits

Using real email notifications provides:
- ✅ **Immediate alerts** for deployment status
- ✅ **Professional communication** with stakeholders
- ✅ **Audit trail** of deployment history
- ✅ **Real-world production practices**

This demonstrates **Senior Release Engineer** expertise in implementing comprehensive notification systems! 🎯
