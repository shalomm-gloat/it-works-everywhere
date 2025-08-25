# 🧪 Simple CI/CD Testing Guide

A quick guide to test the main features of the CI/CD pipeline.

## 🚀 Quick Setup

1. **Fork/clone** the repository
2. **Add these secrets** in GitHub Settings → Secrets and variables → Actions:
   ```
   DOCKER_USERNAME=your-dockerhub-username
   DOCKER_PASSWORD=your-dockerhub-password
   BREVO_SMTP_USER=your-brevo-smtp-user
   BREVO_SMTP_KEY=your-brevo-smtp-key
   ```
3. **Create PR labels** for version bumping:
   - Go to **Issues** → **Labels**
   - Create: `version:major` (red), `version:minor` (blue), `version:patch` (green)

## 🎯 Test the Main Features

### **1. Development Deployment**
```bash
# Make a small change and push to develop
echo "# Test" >> README.md
git add README.md
git commit -m "feat: test deployment"
git push origin develop
```
**Watch**: GitHub Actions → CI/CD Pipeline should deploy with `v1.0.0-dev` tag

### **2. Staging Deployment**
```bash
# Push to staging branch
git checkout staging
git merge develop
git push origin staging
```
**Watch**: Should deploy with `v1.0.0-stg` tag

### **3. Production Deployment**
```bash
# Create PR from develop to staging, then staging to main
# Or push directly to main for testing
git checkout main
git merge develop
git push origin main
```
**Watch**: Should deploy with clean `v1.0.0` tag (no suffix)

### **4. Version Bumping with PR Labels**
```bash
# Create a feature branch
git checkout -b feature/new-feature
echo "# New feature" >> FEATURE.md
git add FEATURE.md
git commit -m "feat: add new feature"
git push origin feature/new-feature

# Create PR to develop
# Add label: version:minor
# Merge the PR
```
**Watch**: Version should automatically bump from `1.0.0` to `1.1.0` based on PR label

### **5. Test Different Version Bump Types**
```bash
# Test Major Version Bump
git checkout -b feature/breaking-change
echo "# Breaking change" >> BREAKING.md
git add BREAKING.md
git commit -m "feat: BREAKING CHANGE: remove deprecated API"
git push origin feature/breaking-change

# Create PR to develop
# Add label: version:major
# Merge the PR
```
**Watch**: Version should bump from `1.1.0` to `2.0.0`

```bash
# Test Patch Version Bump
git checkout -b feature/bug-fix
echo "# Bug fix" >> FIX.md
git add FIX.md
git commit -m "fix: resolve authentication issue"
git push origin feature/bug-fix

# Create PR to develop
# Add label: version:patch
# Merge the PR
```
**Watch**: Version should bump from `2.0.0` to `2.0.1`

### **6. Test No Label (Default Patch)**
```bash
# Create PR without version label
git checkout -b feature/no-label
echo "# No version label" >> NO_LABEL.md
git add NO_LABEL.md
git commit -m "docs: update documentation"
git push origin feature/no-label

# Create PR to develop
# Don't add any version label
# Merge the PR
```
**Watch**: Version should default to patch bump (2.0.1 → 2.0.2)

### **7. Test Manual Version Bump**
```bash
# Test manual bump in workflow
# Go to Actions → CI/CD Pipeline → Run workflow
# Add environment variable: bump-type=minor
# Run workflow
```
**Watch**: Should manually bump version regardless of PR labels

### **8. Emergency Rollback**
1. Go to **Actions** → **Emergency Rollback**
2. Click **"Run workflow"**
3. Enter: Version `v1.0.0`, Environment `production`, Reason `"Testing"`
4. Click **"Run workflow"**

**Watch**: Should rollback to `v1.0.0-rollback` and create a GitHub issue

### **9. Manual Deployment**
1. Go to **Actions** → **CI/CD Pipeline**
2. Click **"Run workflow"**
3. Select environment: `staging`
4. Click **"Run workflow"**

**Watch**: Should deploy to staging environment

### **10. Test Failure**
```bash
# Break a test to see failure handling
echo "expect(true).toBe(false);" >> __tests__/server.test.js
git add __tests__/server.test.js
git commit -m "test: break test"
git push origin develop
```
**Watch**: Pipeline should fail and send failure notification

## 📊 What You Should See

### **Version Tags**
- **Development**: `v1.0.0-dev`
- **Staging**: `v1.0.0-stg` 
- **Production**: `v1.0.0`
- **Rollback**: `v1.0.0-rollback`

### **Version Bumping with PR Labels**
- **`version:major`** → Major version bump (1.0.0 → 2.0.0)
- **`version:minor`** → Minor version bump (1.0.0 → 1.1.0)
- **`version:patch`** → Patch version bump (1.0.0 → 1.0.1)
- **No label** → Default to patch bump

### **Version Flow Through Environments**
```
Feature Branch → PR with version:minor → 1.0.0 → 1.1.0
     ↓
Development → 1.1.0-dev
     ↓
Staging → 1.1.0-stg
     ↓
Production → 1.1.0
```

### **Docker Images**
- **Registry**: `docker.io`
- **Image**: `your-username/it-works-on-my-machine`
- **Tags**: Version-specific tags above

### **Environment URLs**
- **Development**: `https://mydev.getthemilkshake.com`
- **Staging**: `https://mystaging.getthemilkshake.com`
- **Production**: `https://myprod.getthemilkshake.com`

## 🎯 Key Features to Notice

1. **Zero-click deployments** - Just push to branch
2. **PR label versioning** - Explicit version bump control
3. **Quality gates** - Tests, linting, security scanning
4. **Rollback capability** - Emergency rollback workflow
5. **Notifications** - Email alerts for success/failure
6. **Health checks** - Application health monitoring
7. **Automatic version bumping** - Based on PR labels
8. **Environment-specific versions** - Different suffixes per environment

## 🔍 Version Bumping Verification

### **Check Version Bumps**
1. **Monitor package.json changes** in PR commits
2. **Look for [skip ci] commits** - version bump commits
3. **Check Docker image tags** for new versions
4. **Verify environment suffixes** (dev, stg, none for prod)

### **Expected Version Bump Behavior**
- **PR with version:major** → Major version increment
- **PR with version:minor** → Minor version increment  
- **PR with version:patch** → Patch version increment
- **PR with no label** → Default to patch increment
- **Manual workflow** → Respects manual bump type

## 🚨 If Something Fails

1. Check **GitHub Actions logs** for error details
2. Verify **secrets are configured** correctly
3. Test **Docker build locally**: `docker build -t test .`
4. **Check PR labels** are correctly applied
5. **Verify label format** (version:major, version:minor, version:patch)

---

**That's it! This demonstrates a production-ready CI/CD pipeline with all the essential features including PR label-based version bumping.**
