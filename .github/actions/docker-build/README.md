# Docker Build Action

This action builds and pushes Docker images to a registry using official Docker GitHub Actions.

## Purpose

Creates Docker images from the repository code and pushes them to a specified registry with proper tagging and metadata.

## How it works

The action uses official Docker GitHub Actions to:

1. **Setup Buildx**: Configures Docker Buildx for multi-platform builds
2. **Registry Login**: Authenticates with the target registry
3. **Build & Push**: Creates the image and pushes it with specified tags
4. **Metadata**: Adds OpenContainers labels for traceability

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `registry` | Docker registry URL | Yes | `docker.io` |
| `image-name` | Docker image name | Yes | - |
| `username` | Registry username | Yes | - |
| `password` | Registry password | Yes | - |
| `version` | Version tag for the image | Yes | - |

## Outputs

This action has no outputs - it pushes the image directly to the registry.

## Usage

```yaml
- name: Build and push Docker image
  uses: ./.github/actions/docker-build
  with:
    registry: docker.io
    image-name: myapp
    username: ${{ secrets.DOCKER_USERNAME }}
    password: ${{ secrets.DOCKER_PASSWORD }}
    version: ${{ steps.version.outputs.version }}
```

## Docker Tags

The action creates multiple tags for each image:

- **Version tag**: `registry/image:version` (e.g., `docker.io/myapp:v1.0.0-dev+abc123`)
- **Latest tag**: `registry/image:latest` (for easy reference)

## Labels

The action adds OpenContainers labels for traceability:

- `org.opencontainers.image.version`: The version being built
- `org.opencontainers.image.created`: Build timestamp
- `org.opencontainers.image.revision`: Git commit SHA

## Registry Support

This action supports any Docker-compatible registry:

- **Docker Hub**: `docker.io`
- **GitHub Container Registry**: `ghcr.io`
- **AWS ECR**: `account.dkr.ecr.region.amazonaws.com`
- **Azure Container Registry**: `registry.azurecr.io`
- **Google Container Registry**: `gcr.io`

## Best Practices

1. **Multi-platform builds**: Uses Buildx for better compatibility
2. **Security**: Uses secrets for registry credentials
3. **Traceability**: Includes metadata labels
4. **Versioning**: Supports semantic versioning
5. **Caching**: Leverages Docker layer caching

## Dependencies

- Docker Buildx
- Registry credentials
- Dockerfile in repository root
- Version information from previous steps
