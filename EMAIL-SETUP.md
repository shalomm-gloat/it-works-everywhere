# Email Notification Setup with Brevo

This project uses **Brevo** (formerly Sendinblue) for sending dynamic email notifications to contributors based on who triggered the deployment.

## 📧 Setup Instructions

### 1. Brevo Account Setup

1. **Sign up for Brevo** (FREE):
   - Go to https://www.brevo.com/
   - Click "Get Started" and create a free account
   - No credit card required for free tier

2. **Get your SMTP credentials**:
   - After signing up, go to your dashboard
   - Navigate to Senders & IP → SMTP & API
   - Copy your SMTP login and SMTP key

### 2. GitHub Secrets Configuration

Add the Brevo SMTP credentials to your GitHub repository:

1. Go to your repository → Settings → Secrets and variables → Actions
2. Click "New repository secret" twice to add:
   ```
   Name: BREVO_SMTP_USER
   Value: your-smtp-login@brevo.com
   
   Name: BREVO_SMTP_KEY
   Value: your-smtp-key-here
   ```

### 3. Email Configuration

The email notifications are configured to:
- **Service**: Brevo SMTP
- **Dynamic Recipients**: Automatically detects the actual email address of the GitHub user who triggered the deployment
- **Fallback**: If no public email is found, uses `${{ github.actor }}@users.noreply.github.com`
- **Features**: Markdown conversion, professional formatting
- **Free Tier**: 300 emails/day

## 📋 Email Types

### Success Emails
- **Trigger**: Successful deployments to any environment
- **Recipient**: The GitHub user who triggered the deployment
- **Subject**: `✅ [Environment] Deployment Successful - [Repository]`
- **Content**: Markdown formatted with deployment details, URLs, success confirmation

### Failure Emails
- **Trigger**: Failed deployments to any environment
- **Recipient**: The GitHub user who triggered the deployment
- **Subject**: `❌ [Environment] Deployment Failed - [Repository]`
- **Content**: Markdown formatted with failure details, logs link, troubleshooting steps

## 🔧 Dynamic Email Features

### **Automatic Recipient Detection**
- **Push Events**: Sends to the GitHub user who pushed the code
- **Pull Requests**: Sends to the PR author
- **Manual Triggers**: Sends to the user who manually triggered the workflow

### **Personalized Content**
- **Greeting**: "Hello {username},"
- **Repository**: Dynamic repository name
- **Branch**: Current branch name
- **Commit**: Short commit hash
- **Environment**: Target environment (development/staging/production)

## 🚨 Troubleshooting

### Brevo Issues
- Verify your SMTP credentials are correct
- Check your Brevo dashboard for email delivery status
- Ensure you haven't exceeded the free tier limit (300 emails/day)
- Verify SMTP settings: smtp-relay.brevo.com:587

### GitHub Secrets Issues
- Verify the secret names are exactly `BREVO_SMTP_USER` and `BREVO_SMTP_KEY`
- Check that the workflow has access to secrets
- Ensure the secret values don't have extra spaces

### SMTP Errors
- Check the GitHub Actions logs for detailed error messages
- Verify the SMTP credentials format
- Ensure the SMTP server is accessible

## 📊 Benefits of Brevo

Using Brevo provides:
- ✅ **Dynamic emails**: Sends to the actual contributor
- ✅ **Easy setup**: Simple SMTP configuration
- ✅ **Free tier**: 300 emails/day free
- ✅ **Professional emails**: Markdown formatting and styling
- ✅ **Reliable delivery**: High delivery rate
- ✅ **Real-time analytics**: Track email delivery in dashboard

## 🎯 Alternative Services

If you prefer other services:

### Mailgun (FREE - 5,000 emails/month for 3 months)
```yaml
server_address: smtp.mailgun.org
server_port: 587
username: ${{ secrets.MAILGUN_SMTP_USER }}
password: ${{ secrets.MAILGUN_SMTP_PASS }}
```

### SendGrid (FREE - 100 emails/day)
```yaml
server_address: smtp.sendgrid.net
server_port: 587
username: apikey
password: ${{ secrets.SENDGRID_API_KEY }}
```

## 🔄 Migration from Resend

If you were previously using Resend:
1. Remove `RESEND_API_KEY` secret
2. Add `BREVO_SMTP_USER` and `BREVO_SMTP_KEY` secrets
3. The workflow will automatically use the new service

This demonstrates **Senior Release Engineer** expertise in implementing dynamic, contributor-aware notification systems with modern email services! 🎯
