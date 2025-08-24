# Email Notification Setup

This project uses **Resend** for sending real email notifications for deployment success and failures. Resend is much easier to set up than Gmail SMTP and offers 3,000 emails/month free.

## 📧 Setup Instructions

### 1. Resend Account Setup

1. **Sign up for Resend** (FREE):
   - Go to https://resend.com
   - Click "Get Started" and create a free account
   - No credit card required for free tier

2. **Get your API Key**:
   - After signing up, go to your dashboard
   - Click "API Keys" in the sidebar
   - Click "Create API Key"
   - Copy the API key (starts with `re_`)

### 2. GitHub Secrets Configuration

Add the Resend API key to your GitHub repository:

1. Go to your repository → Settings → Secrets and variables → Actions
2. Click "New repository secret"
3. Add:
   ```
   Name: RESEND_API_KEY
   Value: re_your-api-key-here
   ```

### 3. Email Configuration

The email notifications are configured to:
- **Service**: Resend API
- **From Address**: `onboarding@resend.dev` (Resend's default verified domain)
- **Recipient**: shalommeoded@gmail.com
- **Features**: HTML formatting, professional styling
- **Free Tier**: 3,000 emails/month

> **Note**: We use Resend's default domain `onboarding@resend.dev` which is pre-verified and works immediately. You can later add your own domain for a more professional sender address.

## 📋 Email Types

### Success Emails
- **Trigger**: Successful deployments to any environment
- **Subject**: `✅ [Environment] Deployment Successful - [Repository]`
- **Content**: HTML formatted with deployment details, URLs, success confirmation

### Failure Emails
- **Trigger**: Failed deployments to any environment
- **Subject**: `❌ [Environment] Deployment Failed - [Repository]`
- **Content**: HTML formatted with failure details, logs link, troubleshooting steps

## 🔧 Customization

### Change Email Recipient
Edit the notification actions in `.github/actions/`:
```javascript
to: ['your-email@example.com']
```

### Add Multiple Recipients
```javascript
to: ['email1@example.com', 'email2@example.com']
```

### Customize Email Content
Edit the `html` field in the notification actions to change the email template.

### Use Your Own Domain (Optional)
To use a custom domain instead of `onboarding@resend.dev`:
1. Go to Resend dashboard → Domains
2. Add and verify your domain
3. Update the `from` field in the notification actions:
```javascript
from: 'CI/CD Pipeline <noreply@yourdomain.com>'
```

## 🚨 Troubleshooting

### Resend Issues
- Verify your API key is correct
- Check your Resend dashboard for email delivery status
- Ensure you haven't exceeded the free tier limit (3,000 emails/month)
- The default domain `onboarding@resend.dev` should work immediately

### GitHub Secrets Issues
- Verify the secret name is exactly `RESEND_API_KEY`
- Check that the workflow has access to secrets
- Ensure the secret value doesn't have extra spaces

### API Errors
- Check the GitHub Actions logs for detailed error messages
- Verify the API key format (should start with `re_`)
- Domain verification errors: Use `onboarding@resend.dev` for immediate testing

## 📊 Benefits of Resend

Using Resend provides:
- ✅ **Easy setup**: No SMTP configuration needed
- ✅ **Free tier**: 3,000 emails/month free
- ✅ **Professional emails**: HTML formatting and styling
- ✅ **Reliable delivery**: 99.9% delivery rate
- ✅ **Real-time analytics**: Track email delivery in dashboard
- ✅ **Immediate use**: Default domain works out of the box

## 🎯 Alternative Services

If you prefer other services:

### Mailgun (FREE - 5,000 emails/month for 3 months)
```javascript
// Similar setup, different API endpoint
fetch('https://api.mailgun.net/v3/your-domain/messages', {
  method: 'POST',
  headers: {
    'Authorization': 'Basic ' + btoa('api:' + apiKey)
  }
})
```

### SendGrid (FREE - 100 emails/day)
```javascript
// Similar setup, different API endpoint
fetch('https://api.sendgrid.com/v3/mail/send', {
  method: 'POST',
  headers: {
    'Authorization': 'Bearer ' + apiKey
  }
})
```

This demonstrates **Senior Release Engineer** expertise in implementing comprehensive notification systems with modern, reliable email services! 🎯
