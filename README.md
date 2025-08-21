# 🚀 It Works On My Machine - CI/CD Pipeline

A simple Node.js Express microservice with a complete CI/CD pipeline demonstrating the core requirements for a Senior Release Engineer position.

## 📋 Core Requirements Met

### ✅ Must-Have Elements
- **Automated Testing**: Jest with coverage reporting
- **Code Quality Gates**: ESLint for code quality
- **Branching Strategy**: Feature branches → Main branch
- **Versioning Strategy**: Semantic versioning with GitHub releases
- **Deployment Automation**: Zero-click deployments via GitHub Actions

### ✅ Bonus Points
- **Environment Progression**: Development → Production
- **Security Scanning**: npm audit for vulnerability checks
- **Rollback Strategy**: Immutable deployments with version tracking
- **Documentation**: Comprehensive README and inline comments
- **Notification Systems**: GitHub Actions notifications
- **Monitoring & Health Checks**: Built-in health endpoints

## 🚀 Quick Start

### Prerequisites
- Node.js 18+
- Git

### Local Development
```bash
# Clone the repository
git clone <your-repo-url>
cd it-works-on-my-machine

# Install dependencies
npm install

# Run the application
npm start

# Run tests
npm test

# Run linting
npm run lint
```

## 🔧 API Endpoints

### Health Check
```bash
GET /health
```
Returns application health status.

### Metrics
```bash
GET /metrics
```
Returns application metrics in Prometheus format.

### Root
```bash
GET /
```
Returns API information.

## 🔄 CI/CD Pipeline

### Pipeline Flow
```
Feature Branch → PR → Quality Gates → Deploy to Production
```

### Quality Gates
- **Linting**: ESLint code quality checks
- **Testing**: Jest unit tests with coverage
- **Security**: npm audit vulnerability scanning

### Deployment
- **Trigger**: Push to main branch
- **Process**: Automated build and deployment
- **Result**: Zero-click production deployment

## 🎯 Branching Strategy

```
feature/xyz → main (production)
     │
   PR Tests
   Quality Gates
   Auto Deploy
```

## 📊 Success Metrics

- ✅ **Tests Pass**: All unit tests pass
- ✅ **Linting Passes**: Code quality standards met
- ✅ **Security Clean**: No vulnerabilities detected
- ✅ **Deployment Success**: Automated deployment works
- ✅ **Health Checks**: Application responds correctly

## 🔧 Configuration

### Environment Variables
- `PORT`: Application port (default: 3000)
- `NODE_ENV`: Environment (development, production)

### GitHub Secrets Required
- `GITHUB_TOKEN`: Automatically provided by GitHub

## 🚨 Troubleshooting

### Tests Fail
```bash
npm test
```

### Linting Issues
```bash
npm run lint
```

### Health Check
```bash
curl http://localhost:3000/health
```

## 📚 Interview Talking Points

### Why This Approach?
- **Simple but Complete**: Covers all must-have requirements
- **Production Ready**: Actually works and deploys
- **Industry Standard**: Uses proven tools and practices
- **Zero Complexity**: Easy to understand and maintain

### Key Decisions
- **GitHub Actions**: Free, integrated, no infrastructure
- **Jest**: Most popular Node.js testing framework
- **ESLint**: Industry standard for code quality
- **npm audit**: Built-in security scanning

---

**Built with ❤️ for production-ready CI/CD pipelines**
