#!/bin/bash

# Version Management Script
# Handles semantic versioning and release automation

set -e

# Configuration
PACKAGE_JSON="package.json"
CHANGELOG_FILE="CHANGELOG.md"
RELEASE_NOTES_DIR="release-notes"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo -e "${BLUE}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} $1"
}

# Error function
error() {
    echo -e "${RED}ERROR:${NC} $1" >&2
    exit 1
}

# Success function
success() {
    echo -e "${GREEN}SUCCESS:${NC} $1"
}

# Warning function
warning() {
    echo -e "${YELLOW}WARNING:${NC} $1"
}

# Get current version from package.json
get_current_version() {
    if [ -f "$PACKAGE_JSON" ]; then
        node -p "require('./$PACKAGE_JSON').version"
    else
        error "package.json not found"
    fi
}

# Get next version based on type
get_next_version() {
    local current_version=$1
    local version_type=$2
    
    # Parse version components
    IFS='.' read -r major minor patch <<< "$current_version"
    
    case $version_type in
        "major")
            major=$((major + 1))
            minor=0
            patch=0
            ;;
        "minor")
            minor=$((minor + 1))
            patch=0
            ;;
        "patch")
            patch=$((patch + 1))
            ;;
        *)
            error "Invalid version type: $version_type. Use major, minor, or patch"
            ;;
    esac
    
    echo "$major.$minor.$patch"
}

# Update package.json version
update_package_version() {
    local new_version=$1
    
    log "Updating package.json version to $new_version"
    
    # Update version in package.json
    node -e "
        const fs = require('fs');
        const pkg = JSON.parse(fs.readFileSync('$PACKAGE_JSON', 'utf8'));
        pkg.version = '$new_version';
        fs.writeFileSync('$PACKAGE_JSON', JSON.stringify(pkg, null, 2) + '\n');
    "
    
    success "Updated package.json version to $new_version"
}

# Generate changelog
generate_changelog() {
    local new_version=$1
    local previous_version=$2
    
    log "Generating changelog for version $new_version"
    
    # Create changelog directory if it doesn't exist
    mkdir -p "$RELEASE_NOTES_DIR"
    
    # Generate changelog from git commits
    local changelog_file="$RELEASE_NOTES_DIR/v$new_version.md"
    
    cat > "$changelog_file" << EOF
# Release v$new_version

## Changes since v$previous_version

\`\`\`
$(git log --oneline "v$previous_version..HEAD" 2>/dev/null || git log --oneline HEAD~10..HEAD)
\`\`\`

## Summary

- **Version**: $new_version
- **Release Date**: $(date '+%Y-%m-%d')
- **Previous Version**: $previous_version

## Breaking Changes

$(git log --oneline --grep="BREAKING CHANGE" "v$previous_version..HEAD" 2>/dev/null || echo "None")

## Features

$(git log --oneline --grep="feat:" "v$previous_version..HEAD" 2>/dev/null || echo "None")

## Bug Fixes

$(git log --oneline --grep="fix:" "v$previous_version..HEAD" 2>/dev/null || echo "None")

## Other Changes

$(git log --oneline --grep="chore:\|docs:\|style:\|refactor:\|test:\|perf:" "v$previous_version..HEAD" 2>/dev/null || echo "None")
EOF
    
    success "Generated changelog: $changelog_file"
}

# Create git tag
create_git_tag() {
    local version=$1
    
    log "Creating git tag v$version"
    
    # Check if tag already exists
    if git tag -l "v$version" | grep -q "v$version"; then
        warning "Tag v$version already exists"
        return 0
    fi
    
    # Create tag
    git tag "v$version"
    success "Created git tag v$version"
}

# Push changes to remote
push_changes() {
    local version=$1
    
    log "Pushing changes to remote repository"
    
    # Add all changes
    git add .
    
    # Commit version bump
    git commit -m "chore: bump version to v$version"
    
    # Push changes
    git push origin main
    
    # Push tag
    git push origin "v$version"
    
    success "Pushed changes and tag v$version to remote"
}

# Validate git status
validate_git_status() {
    log "Validating git status"
    
    # Check if we're on main branch
    local current_branch=$(git branch --show-current)
    if [ "$current_branch" != "main" ]; then
        error "Must be on main branch to create a release. Current branch: $current_branch"
    fi
    
    # Check if working directory is clean
    if ! git diff-index --quiet HEAD --; then
        error "Working directory is not clean. Please commit or stash changes."
    fi
    
    # Check if we're up to date with remote
    git fetch origin
    local local_commit=$(git rev-parse HEAD)
    local remote_commit=$(git rev-parse origin/main)
    
    if [ "$local_commit" != "$remote_commit" ]; then
        error "Local main branch is not up to date with remote. Please pull latest changes."
    fi
    
    success "Git status validation passed"
}

# Main release function
create_release() {
    local version_type=$1
    
    log "Creating $version_type release"
    
    # Get current version
    local current_version=$(get_current_version)
    log "Current version: $current_version"
    
    # Calculate next version
    local next_version=$(get_next_version "$current_version" "$version_type")
    log "Next version: $next_version"
    
    # Validate git status
    validate_git_status
    
    # Update package.json
    update_package_version "$next_version"
    
    # Generate changelog
    generate_changelog "$next_version" "$current_version"
    
    # Create git tag
    create_git_tag "$next_version"
    
    # Push changes
    push_changes "$next_version"
    
    success "Release v$next_version created successfully!"
    
    echo ""
    echo "🎉 Release Summary:"
    echo "  Version: v$next_version"
    echo "  Type: $version_type"
    echo "  Changelog: $RELEASE_NOTES_DIR/v$next_version.md"
    echo "  Tag: v$next_version"
    echo ""
    echo "Next steps:"
    echo "  1. Review the changelog: $RELEASE_NOTES_DIR/v$next_version.md"
    echo "  2. GitHub Actions will automatically build and deploy"
    echo "  3. Monitor the deployment in GitHub Actions"
}

# Show current version
show_version() {
    local current_version=$(get_current_version)
    echo "Current version: $current_version"
    
    echo ""
    echo "Next versions:"
    echo "  Patch: $(get_next_version "$current_version" "patch")"
    echo "  Minor: $(get_next_version "$current_version" "minor")"
    echo "  Major: $(get_next_version "$current_version" "major")"
}

# Show usage
show_usage() {
    echo "Usage: $0 [COMMAND] [OPTIONS]"
    echo ""
    echo "Commands:"
    echo "  patch    Create a patch release (bug fixes)"
    echo "  minor    Create a minor release (new features)"
    echo "  major    Create a major release (breaking changes)"
    echo "  version  Show current version and next versions"
    echo "  help     Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 patch    # 1.0.0 -> 1.0.1"
    echo "  $0 minor    # 1.0.1 -> 1.1.0"
    echo "  $0 major    # 1.1.0 -> 2.0.0"
}

# Main script logic
case "${1:-help}" in
    "patch"|"minor"|"major")
        create_release "$1"
        ;;
    "version")
        show_version
        ;;
    "help"|"--help"|"-h")
        show_usage
        ;;
    *)
        error "Unknown command: $1"
        show_usage
        exit 1
        ;;
esac
