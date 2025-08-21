# 🚀 It Works On My Machine - Production-Ready CI/CD Pipeline

A comprehensive CI/CD pipeline demonstration for a Node.js Express microservice, showcasing industry best practices for production deployment.

## 📋 Overview

This project demonstrates a **Senior Release Engineer** approach to transforming a local development project into a production-ready system with:

- ✅ **Zero-downtime deployments** with health checks
- ✅ **Comprehensive security scanning** (SAST, DAST, container, dependencies)
- ✅ **Automated testing** with coverage requirements
- ✅ **Observability** built-in (metrics, logs, health checks)
- ✅ **Supply chain security** with SBOM generation
- ✅ **Production-ready containerization** with multi-stage builds

## 🏗️ Architecture

### Pipeline Flow

```
Feature PR → Quality Gates → Security Scan → Build → Deploy → Health Check → Release
```

### Tools & Technologies

- **Quality**: ESLint, Prettier, Jest, Supertest
- **Security**: Gitleaks, Trivy, CodeQL, Hadolint
- **Container**: Docker Buildx, GitHub Container Registry (GHCR)
- **CI/CD**: GitHub Actions
- **Monitoring**: Prometheus metrics, health checks
- **SBOM**: Syft for supply chain security

## 🚀 Quick Start

### Prerequisites

- Node.js 18+
- Docker & Docker Compose
- Git

### Local Development

```bash
# Clone the repository
git clone <your-repo-url>
cd it-works-on-my-machine

# Install dependencies
make install

# Run the application
make run

# Or use the quick start
make quick-start
```

### Available Commands

```bash
make help          # Show all available commands
make test          # Run tests with coverage
make lint          # Run ESLint
make format        # Format code with Prettier
make security      # Run security audit
make docker-build  # Build Docker image
make deploy        # Deploy to test environment
make health        # Check application health
make metrics       # View application metrics
```

## 🔧 API Endpoints

### Health Check

```bash
GET /health
```

Returns application health status with uptime and version information.

### Metrics (Prometheus Format)

```bash
GET /metrics
```

Returns application metrics in Prometheus format for monitoring.

### Root

```bash
GET /
```

Returns API information and available endpoints.

## 🐳 Docker

### Build Image

```bash
make docker-build
```

### Run Container

```bash
make docker-run
```

### Development with Docker Compose

```bash
# Start development environment
docker-compose up app

# Run tests in container
docker-compose run --rm app-test

# Start production-like environment
docker-compose up app-prod
```

## 🔒 Security Features

### Secret Detection (Gitleaks)

- Scans code for hardcoded secrets
- Prevents accidental commit of sensitive data
- Custom rules for API keys, passwords, tokens

### Vulnerability Scanning (Trivy)

- Container image vulnerability scanning
- Dependency vulnerability scanning
- Filesystem security scanning

### Static Analysis (CodeQL)

- GitHub's SAST tool
- Finds security vulnerabilities in source code
- Language-specific analysis for Node.js

### Container Security (Hadolint)

- Dockerfile best practices
- Security-focused linting
- Prevents common container security issues

## 📊 Monitoring & Observability

### Health Checks

- `/health` endpoint for load balancer health checks
- Docker HEALTHCHECK for container orchestration
- Automated rollback on health check failures

### Metrics

- Prometheus-formatted metrics
- Request counters and uptime tracking
- Ready for integration with monitoring systems

### Logging

- Structured logging with request tracking
- Performance metrics (response times)
- Error handling with proper logging

## 🔄 CI/CD Pipeline

### GitHub Actions Workflows

#### 1. CI Pipeline (`ci.yml`)

Runs on every PR and push to main:

- **Quality Gates**: Lint, format, test, coverage
- **Security Scan**: Gitleaks, Trivy, CodeQL
- **Build**: Multi-platform Docker image
- **Container Security**: Hadolint, Trivy image scan
- **SBOM**: Generate Software Bill of Materials
- **Deploy**: Test environment deployment
- **Health Check**: Automated health verification

#### 2. Release Pipeline (`release.yml`)

Runs on semantic version tags:

- **Changelog Generation**: Auto-generated from commits
- **GitHub Release**: Create release with notes
- **SBOM Attachment**: Attach SBOM to release
- **Notification**: Stakeholder notifications

### Pipeline Stages

#### Quality Gates (PR)

```
lint → format → test → coverage → security-scan
```

#### Build & Security (Main)

```
build-image → trivy-scan → syft-sbom → hadolint → push-ghcr
```

#### Deploy & Verify (Main)

```
deploy → health-check → metrics-verify → smoke-test
```

## 🎯 Production Features

### Zero-Downtime Deployment

- Blue/green deployment strategy
- Health check automation
- Instant rollback capabilities

### Security First

- Multi-layer security scanning
- Container signing and verification
- Supply chain security with SBOM

### Observability

- Built-in metrics and health checks
- Structured logging
- Performance monitoring

### Scalability

- Multi-platform container builds
- Environment progression (dev → staging → prod)
- Infrastructure as Code

## 📈 Success Metrics

### Technical Excellence

- ✅ Zero security vulnerabilities
- ✅ 100% test coverage (or justification)
- ✅ All linting rules pass
- ✅ SBOM generated and attached
- ✅ Health checks pass consistently

### Operational Excellence

- ✅ Automated testing on every PR
- ✅ Immutable container tags
- ✅ Security scanning in CI/CD
- ✅ Observability built-in
- ✅ Infrastructure as Code

## 🔧 Configuration

### Environment Variables

- `PORT`: Application port (default: 3000)
- `NODE_ENV`: Environment (development, test, production)

### GitHub Secrets Required

- `GITHUB_TOKEN`: Automatically provided by GitHub
- Additional secrets for production deployment (if needed)

## 🚨 Troubleshooting

### Common Issues

#### Health Check Fails

```bash
# Check if application is running
make health

# Check logs
docker logs <container-name>

# Verify port binding
netstat -tulpn | grep 3000
```

#### Tests Fail

```bash
# Run tests locally
make test

# Check test coverage
open coverage/lcov-report/index.html

# Run specific test file
npm test -- __tests__/server.test.js
```

#### Docker Build Fails

```bash
# Clean Docker cache
docker system prune -a

# Rebuild without cache
docker build --no-cache -t it-works-on-my-machine .
```

## 📚 Interview Talking Points

### Why These Tools?

- **GitHub Actions**: Free, integrated, no infrastructure to manage
- **GHCR**: Free, secure, integrates with GitHub security features
- **Trivy**: Industry standard, comprehensive, free
- **SBOM**: Supply chain security, compliance, transparency
- **Health Checks**: Essential for container orchestration

### Production Readiness

- **Zero-downtime deployments** with blue/green strategy
- **Comprehensive security** with multiple scanning layers
- **Full observability** with metrics, logs, and traces
- **Scalable architecture** that can handle growth
- **Operational excellence** with clear procedures

### Best Practices Demonstrated

- **Security-first approach** with multiple scanning layers
- **Automated testing** at multiple levels
- **Immutable infrastructure** with signed containers
- **Monitoring and alerting** for production systems
- **Documentation** for operations and troubleshooting

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run the full CI pipeline locally: `make ci`
5. Submit a pull request

## 📄 License

MIT License - see LICENSE file for details.

---

**Built with ❤️ for production-ready CI/CD pipelines**
