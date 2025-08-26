# 🧪 CI/CD Testing Guide

A simple, focused guide to test the production-ready CI/CD pipeline.

## 🚀 Quick Setup

1. **Fork/clone** the repository
2. **Add these secrets** in GitHub Settings → Secrets and variables → Actions:
   ```
   DOCKER_USERNAME=your-dockerhub-username
   DOCKER_PASSWORD=your-dockerhub-password
   BREVO_SMTP_USER=your-brevo-smtp-user
   BREVO_SMTP_KEY=your-brevo-smtp-key
   ```

## 🎯 Core Test Scenarios

### **1. Test Versioning (Main Branch)**
```bash
# Create a feature commit
echo "# Test feature" >> test-feature.md
git add test-feature.md
git commit -m "feat: add test feature"
git push origin main
```
**Expected**: Version bumps from `1.0.12` → `1.1.0` (minor bump)

### **2. Test Versioning (Fix Commit)**
```bash
# Create a fix commit
echo "# Test fix" >> test-fix.md
git add test-fix.md
git commit -m "fix: add test fix"
git push origin main
```
**Expected**: Version bumps from `1.1.0` → `1.1.1` (patch bump)

### **3. Test Version Preview (PR)**
```bash
# Create PR with feature
git checkout -b feature/test-preview
echo "# PR test" >> pr-test.md
git add pr-test.md
git commit -m "feat: add PR test feature"
git push origin feature/test-preview
# Create PR to main
```
**Expected**: Version preview comment shows `1.1.1` → `1.2.0`

### **4. Test Progressive Deployment (Dev → Staging → Prod)**
```bash
# Start from a clean state - sync all branches
git checkout main && git pull origin main
git checkout develop && git pull origin develop
git checkout staging && git pull origin staging

# 1. Development Environment
git checkout develop
git checkout -b "feature/test-1"
echo "# Dev feature" >> dev-feature.md
git add dev-feature.md
git commit -m "feat: add development feature"
git push origin develop
# Expected: Deploys to development, no version bump

# 2. Staging Environment (merge develop into staging)
git checkout staging
git merge develop
git push origin staging
# Expected: Deploys to staging, no version bump

# 3. Production Environment (merge staging into main)
git checkout main
git merge staging
git push origin main
# Expected: Deploys to production, version bump based on commits
```

**💡 If branches are out of sync:**
```bash
# Reset all branches to main
git checkout main && git pull origin main
git checkout develop && git reset --hard main && git push origin develop --force
git checkout staging && git reset --hard main && git push origin staging --force
```

### **5. Test Failure Handling**
```bash
# Break a test
echo "expect(true).toBe(false);" >> __tests__/server.test.js
git add __tests__/server.test.js
git commit -m "test: break test"
git push origin main
```
**Expected**: Pipeline fails, failure notification sent

## 📊 Success Criteria

### **✅ Versioning Works**
- `feat:` commits → Minor version bump
- `fix:` commits → Patch version bump
- `BREAKING CHANGE:` → Major version bump

### **✅ Deployment Works**
- Docker images built and pushed
- Environment-specific tags (`-dev`, `-stg`, `-prod`)
- GitHub tags created automatically
- Progressive deployment: dev → staging → prod

### **✅ Notifications Work**
- Success emails sent on deployment
- Failure emails sent on errors
- PR comments with version previews

### **✅ Quality Gates**
- Tests pass
- Linting passes
- Security scan clean

## 🔍 Verification Steps

### **Check Version Bumps**
```bash
# Check package.json version
cat package.json | grep '"version"'

# Check GitHub tags
git tag --sort=-version:refname | head -5

# Check Docker images
docker images | grep your-image-name
```

### **Check GitHub Actions**
1. Go to **Actions** tab
2. Look for **CI/CD Pipeline** workflow (`ci-cd.yml`)
3. Verify **Version Management** job runs
4. Check **Build & Deploy** job succeeds

## 🚨 Troubleshooting

### **If Versioning Doesn't Work**
1. Check **Version Management** job logs
2. Verify commit messages follow conventional format
3. Ensure you're on `main` branch

### **If Deployment Fails**
1. Check **Build & Deploy** job logs
2. Verify Docker secrets are configured
3. Check Docker Hub permissions

### **If Notifications Don't Work**
1. Check **Notify Success/Failure** job logs
2. Verify email secrets are configured
3. Check email provider settings

## 📈 Expected Results

### **Version Flow**
```
1.0.12 → feat: commit → 1.1.0 (minor)
1.1.0  → fix: commit  → 1.1.1 (patch)
1.1.1  → feat: commit → 1.2.0 (minor)
```

### **Progressive Deployment Flow**
```
Feature Branch → PR Preview
     ↓
Development → Deploy to dev (no version bump)
     ↓
Staging → Deploy to staging (no version bump)
     ↓
Production → Deploy to prod + version bump
```

### **Docker Tags**
```
v1.1.0-prod    (production)
v1.1.0-stg     (staging)
v1.1.0-dev     (development)
```

### **GitHub Tags**
```
v1.1.0, v1.1.1, v1.2.0 (automatic)
```

---

**This demonstrates a production-ready CI/CD pipeline with conventional commits, automated versioning, and progressive deployment!**
