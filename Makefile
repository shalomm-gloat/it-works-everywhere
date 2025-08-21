# Makefile for It Works On My Machine
# Standard development targets for local development

.PHONY: help install test lint build run clean docker-build docker-run docker-push health-check

# Default target
help:
	@echo "Available targets:"
	@echo "  install      - Install dependencies"
	@echo "  test         - Run tests with coverage"
	@echo "  lint         - Run linting checks"
	@echo "  build        - Build the application"
	@echo "  run          - Start the application locally"
	@echo "  clean        - Clean build artifacts"
	@echo "  docker-build - Build Docker image"
	@echo "  docker-run   - Run Docker container"
	@echo "  docker-push  - Push Docker image to registry"
	@echo "  health-check - Check application health"

# Install dependencies
install:
	@echo "Installing dependencies..."
	yarn install

# Run tests with coverage
test:
	@echo "Running tests with coverage..."
	yarn test

# Run linting checks
lint:
	@echo "Running linting checks..."
	yarn lint

# Build the application
build:
	@echo "Building application..."
	yarn build

# Start the application locally
run:
	@echo "Starting application on http://localhost:3000"
	@echo "Health check: http://localhost:3000/health"
	@echo "Metrics: http://localhost:3000/metrics"
	yarn start

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	rm -rf coverage/
	rm -rf node_modules/
	rm -rf .nyc_output/

# Build Docker image
docker-build:
	@echo "Building Docker image..."
	docker build -t it-works-on-my-machine .

# Run Docker container
docker-run:
	@echo "Running Docker container..."
	docker run -d -p 3000:3000 --name it-works-app it-works-on-my-machine
	@echo "Application running on http://localhost:3000"

# Push Docker image to registry
docker-push:
	@echo "Pushing Docker image to registry..."
	docker tag it-works-on-my-machine ghcr.io/$(shell git config user.name)/it-works-on-my-machine:latest
	docker push ghcr.io/$(shell git config user.name)/it-works-on-my-machine:latest

# Check application health
health-check:
	@echo "Checking application health..."
	@curl -f http://localhost:3000/health || (echo "Health check failed" && exit 1)
	@echo "Health check passed"
	@curl -s http://localhost:3000/metrics | grep -q "http_requests_total" || (echo "Metrics check failed" && exit 1)
	@echo "Metrics check passed"

# Development workflow
dev: install lint test build
	@echo "Development workflow completed successfully"

# Production workflow
prod: install lint test build docker-build
	@echo "Production workflow completed successfully"
