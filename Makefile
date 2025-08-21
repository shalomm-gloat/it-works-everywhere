# Makefile for It Works On My Machine
# Senior Release Engineer CI/CD Pipeline

.PHONY: help install test lint format security build run clean docker-build docker-run docker-test deploy

# Default target
help:
	@echo "🚀 It Works On My Machine - CI/CD Pipeline"
	@echo ""
	@echo "Available commands:"
	@echo "  install      - Install dependencies"
	@echo "  test         - Run tests with coverage"
	@echo "  lint         - Run ESLint"
	@echo "  format       - Format code with Prettier"
	@echo "  security     - Run security audit"
	@echo "  build        - Build the application"
	@echo "  run          - Run the application locally"
	@echo "  clean        - Clean build artifacts"
	@echo "  docker-build - Build Docker image"
	@echo "  docker-run   - Run Docker container"
	@echo "  docker-test  - Run tests in Docker"
	@echo "  deploy       - Deploy to test environment"
	@echo "  health       - Check application health"
	@echo "  metrics      - View application metrics"

# Install dependencies
install:
	@echo "📦 Installing dependencies..."
	npm ci

# Run tests with coverage
test:
	@echo "🧪 Running tests with coverage..."
	npm test

# Run ESLint
lint:
	@echo "🔍 Running ESLint..."
	npm run lint

# Format code with Prettier
format:
	@echo "✨ Formatting code with Prettier..."
	npm run format

# Run security audit
security:
	@echo "🔒 Running security audit..."
	npm run security:check

# Build the application
build:
	@echo "🔨 Building application..."
	npm run build

# Run the application locally
run:
	@echo "🚀 Starting application..."
	npm start

# Clean build artifacts
clean:
	@echo "🧹 Cleaning build artifacts..."
	rm -rf node_modules
	rm -rf coverage
	rm -rf .nyc_output
	rm -rf dist
	rm -rf build

# Build Docker image
docker-build:
	@echo "🐳 Building Docker image..."
	docker build -t it-works-on-my-machine:latest .

# Run Docker container
docker-run:
	@echo "🐳 Running Docker container..."
	docker run -p 3000:3000 --name it-works-app it-works-on-my-machine:latest

# Run tests in Docker
docker-test:
	@echo "🐳 Running tests in Docker..."
	docker-compose run --rm app-test

# Deploy to test environment
deploy:
	@echo "🚀 Deploying to test environment..."
	docker-compose up -d app-prod
	@echo "⏳ Waiting for deployment to stabilize..."
	sleep 10
	@echo "🏥 Running health checks..."
	curl -f http://localhost:3002/health || (echo "❌ Health check failed" && exit 1)
	@echo "✅ Deployment successful!"

# Check application health
health:
	@echo "🏥 Checking application health..."
	curl -s http://localhost:3000/health | jq . || curl -s http://localhost:3000/health

# View application metrics
metrics:
	@echo "📊 Viewing application metrics..."
	curl -s http://localhost:3000/metrics

# Development workflow
dev: install lint format test security
	@echo "✅ Development workflow completed!"

# CI workflow simulation
ci: install lint format test security docker-build docker-test
	@echo "✅ CI workflow completed!"

# Production deployment workflow
prod: ci deploy
	@echo "✅ Production deployment completed!"

# Quick start for development
quick-start: install run
	@echo "✅ Quick start completed! Application running on http://localhost:3000"
