# 🧪 CI/CD Testing Guide

A comprehensive guide to test the production-ready CI/CD pipeline with progressive deployment and conventional commits.

## 🚀 Quick Setup

1. **Fork/clone** the repository
2. **Add these secrets** in GitHub Settings → Secrets and variables → Actions:
   ```
   DOCKER_USERNAME=your-dockerhub-username
   DOCKER_PASSWORD=your-dockerhub-password
   BREVO_SMTP_USER=your-brevo-smtp-user
   BREVO_SMTP_KEY=your-brevo-smtp-key
   ```

## 🎯 Test Scenarios

### **1. Version Preview on PRs**
```bash
git checkout -b feature/test-preview
echo "# Test feature" >> TEST.md
git add TEST.md && git commit -m "feat: add test feature"
git push origin feature/test-preview
# Create PR to develop
```
**Watch**: Version Preview job creates PR comment with version info

### **2. Progressive Deployment Flow**
```bash
# Development
git checkout develop && git merge feature/test-preview && git push origin develop

# Staging  
git checkout staging && git merge develop && git push origin staging

# Production
git checkout main && git merge staging && git push origin main
```
**Watch**: 
- **Dev/Staging**: No version bump, same version flows through
- **Production**: Version bump based on conventional commits

### **3. Conventional Commit Versioning**
```bash
# Minor bump (feat:)
git commit -m "feat: add user authentication system"
# → 1.0.0 → 1.1.0

# Patch bump (fix:)
git commit -m "fix: resolve login timeout issue"  
# → 1.1.0 → 1.1.1

# Major bump (BREAKING CHANGE)
git commit -m "feat: BREAKING CHANGE: redesign API endpoints"
# → 1.1.1 → 2.0.0

# No bump (docs:, chore:)
git commit -m "docs: update deployment guide"
# → No version change
```

### **4. Failure Handling**
```bash
echo "expect(true).toBe(false);" >> __tests__/server.test.js
git add __tests__/server.test.js && git commit -m "test: break test"
git push origin develop
```
**Watch**: Pipeline fails, failure notification sent

### **5. Email Notifications**
```bash
echo "# Success test" >> SUCCESS.md
git add SUCCESS.md && git commit -m "feat: test success notification"
git push origin develop
```
**Watch**: Success notification sent to your email

## 📊 Expected Results

### **Version Preview Comments**
```
## 📋 Version Preview
**Current Version:** 1.0.0
**Preview Version:** 1.0.1
**Target Branch:** develop
**Bump Type:** patch (default for develop)
```

### **Conventional Commit Rules**
- **`feat:`** → Minor version bump (1.0.0 → 1.1.0)
- **`fix:`** → Patch version bump (1.1.0 → 1.1.1)
- **`BREAKING CHANGE:`** → Major version bump (1.1.1 → 2.0.0)
- **`docs:, chore:`** → No version bump

### **Environment Flow**
```
Feature Branch → PR Preview → 1.0.0
     ↓
Development → 1.0.0 (no bump)
     ↓
Staging → 1.0.0 (no bump)
     ↓
Production → 1.0.1 (bump based on commits)
```

### **Docker Images & Tags**
- **Development**: `v1.0.0-dev`
- **Staging**: `v1.0.0-stg`
- **Production**: `v1.0.1-prod`

### **GitHub Tags**
- **Automatic creation**: `v1.0.1`, `v1.1.0`, `v2.0.0`
- **Annotated tags**: With release messages

## 🎯 Key Features to Verify

1. **Version Preview**: Shows on PRs before merge
2. **Conventional Commits**: Automatic version bumping
3. **Progressive Deployment**: Code flows through environments
4. **Same Version Strategy**: No bumps on develop/staging
5. **GitHub Tags**: Automatic tag creation
6. **Email Notifications**: Success/failure alerts
7. **PR Comments**: Version preview and deployment notifications
8. **Quality Gates**: Tests, linting, security

## 🔍 Version Bumping Verification

### **Check Version Bumps**
1. **Monitor package.json changes** in commits
2. **Look for [skip ci] commits** - version bump commits
3. **Check GitHub tags** for new releases
4. **Verify Docker image tags** for new versions
5. **Check commit message analysis** in versioning job logs

### **Expected Behavior**
- **Develop/Staging**: No version bump (maintains same version)
- **Main**: Version bump based on conventional commits
- **GitHub Tags**: Created automatically for each release
- **Docker Tags**: Environment-specific suffixes

## 🚨 If Something Fails

1. **Check GitHub Actions logs** for detailed error information
2. **Verify secrets are configured** correctly
3. **Test Docker build locally**: `docker build -t test .`
4. **Check commit messages** follow conventional commit format
5. **Verify branch permissions** and workflow triggers

## 📈 Success Metrics

- **Version Preview**: Shows correctly on PRs
- **Progressive Deployment**: Code flows through environments
- **Conventional Commits**: Version bumps based on commit types
- **GitHub Tags**: Automatic tag creation
- **Email Notifications**: Success/failure alerts sent
- **Quality Gates**: Tests pass, security scan clean

---

**This demonstrates a production-ready CI/CD pipeline with industry best practices including conventional commits, progressive deployment, and automated versioning!**
