# 🚀 Deployment Guide - Phase 1

## 📋 Overview

This guide covers the deployment process for **Phase 1: Setup & Foundation** of the "It Works On My Machine" project.

## 🎯 What's Deployed

- **Node.js Express microservice** with health endpoint
- **Docker container** pushed to GitHub Container Registry
- **Automated CI/CD pipeline** with quality gates
- **Production-ready** configuration

## 🔄 Deployment Process

### **1. Automatic Deployment (Recommended)**

#### **Push to Main Branch**
```bash
# Any push to main triggers automatic deployment
git push origin main
```

**What happens automatically:**
1. ✅ **Quality Gates**: Lint, test, security audit
2. ✅ **Docker Build**: Container image creation
3. ✅ **Registry Push**: GitHub Container Registry
4. ✅ **Deployment**: Production deployment

#### **Create a Release**
```bash
# Create and push a tag
git tag v1.0.0
git push origin v1.0.0
```

**What happens automatically:**
1. ✅ **Release Build**: Tagged Docker image
2. ✅ **GitHub Release**: Release notes and artifacts
3. ✅ **Registry Tags**: Versioned container images

### **2. Manual Deployment**

#### **Local Docker Build**
```bash
# Build the image locally
docker build -t it-works-on-my-machine .

# Run locally
docker run -p 3000:3000 it-works-on-my-machine
```

#### **Pull from Registry**
```bash
# Pull the latest image
docker pull ghcr.io/<username>/it-works-on-my-machine:latest

# Run the container
docker run -p 3000:3000 ghcr.io/<username>/it-works-on-my-machine:latest
```

## 📊 Quality Gates

### **Pre-Deployment Checks**
- ✅ **Linting**: ESLint passes with no errors
- ✅ **Testing**: Jest tests pass with coverage
- ✅ **Security**: npm audit passes (no moderate+ vulnerabilities)
- ✅ **Health Check**: Application responds correctly

### **Deployment Validation**
- ✅ **Docker Build**: Image builds successfully
- ✅ **Registry Push**: Image pushed to GHCR
- ✅ **Health Endpoint**: `/health` returns 200 OK

## 🔧 Configuration

### **Environment Variables**
```bash
PORT=3000          # Application port (default: 3000)
NODE_ENV=production # Environment (development/production)
```

### **Docker Configuration**
- **Base Image**: `node:18-alpine`
- **Port**: `3000`
- **Health Check**: Built-in endpoint
- **Registry**: GitHub Container Registry (GHCR)

## 📈 Monitoring

### **Health Monitoring**
```bash
# Check application health
curl http://localhost:3000/health

# Expected response
"Still working... on *my* machine 🧃"
```

### **Container Health**
```bash
# Check container status
docker ps

# Check container logs
docker logs <container-id>
```

## 🚨 Troubleshooting

### **Common Issues**

#### **Build Failures**
```bash
# Check Docker build logs
docker build -t it-works-on-my-machine . --progress=plain

# Verify Dockerfile syntax
docker build --dry-run .
```

#### **Runtime Issues**
```bash
# Check application logs
docker logs <container-id>

# Verify port binding
docker port <container-id>

# Test health endpoint
curl http://localhost:3000/health
```

#### **Registry Issues**
```bash
# Verify authentication
docker login ghcr.io

# Check image tags
docker images ghcr.io/<username>/it-works-on-my-machine
```

## 📋 Deployment Checklist

### **Pre-Deployment**
- [ ] All tests pass locally (`yarn test`)
- [ ] Linting passes (`yarn lint`)
- [ ] Security audit passes (`yarn audit`)
- [ ] Health check works (`./test.sh`)
- [ ] Docker build succeeds (`docker build .`)

### **Deployment**
- [ ] Push to main branch
- [ ] CI/CD pipeline runs successfully
- [ ] Docker image pushed to registry
- [ ] Health endpoint responds correctly
- [ ] Application accessible on target port

### **Post-Deployment**
- [ ] Verify health endpoint
- [ ] Check application logs
- [ ] Monitor resource usage
- [ ] Validate functionality

## 🎯 Success Criteria

### **Phase 1 Complete When:**
- ✅ **Public GitHub Repository**: Code is version-controlled and accessible
- ✅ **CI/CD Pipeline**: Automated testing and deployment
- ✅ **Production-Ready**: Docker containerization and security scanning
- ✅ **Proper Deployment**: Automated deployment practices

## 📚 Next Steps

After **Phase 1** is complete, consider implementing:
- **Environment progression** (dev → staging → prod)
- **Advanced security scanning** (Trivy, CodeQL)
- **Performance testing** and monitoring
- **Rollback strategies**
- **Advanced deployment patterns**

---

**This deployment guide ensures reliable, automated deployments with proper quality gates and monitoring.** 🏆
