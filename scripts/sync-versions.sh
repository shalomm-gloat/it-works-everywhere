#!/bin/bash

# Version Synchronization Script
# Automatically syncs package.json version across all branches

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
MAIN_BRANCH="main"
BRANCHES=("develop" "staging")
PACKAGE_JSON="package.json"

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
get_version() {
    if [ -f "$PACKAGE_JSON" ]; then
        node -p "require('./$PACKAGE_JSON').version"
    else
        error "package.json not found"
    fi
}

# Update package.json version
update_version() {
    local new_version=$1
    log "Updating package.json to version: $new_version"
    
    node -e "
        const fs = require('fs');
        const pkg = JSON.parse(fs.readFileSync('$PACKAGE_JSON', 'utf8'));
        pkg.version = '$new_version';
        fs.writeFileSync('$PACKAGE_JSON', JSON.stringify(pkg, null, 2) + '\n');
    "
}

# Sync version to a branch
sync_branch() {
    local branch=$1
    local version=$2
    
    log "Syncing version $version to branch: $branch"
    
    # Check if branch exists
    if ! git show-ref --verify --quiet refs/remotes/origin/$branch; then
        warning "Branch $branch doesn't exist remotely, skipping"
        return 0
    fi
    
    # Checkout branch
    git checkout $branch
    
    # Pull latest changes
    git pull origin $branch
    
    # Get current version on this branch
    local current_version=$(get_version)
    
    if [ "$current_version" != "$version" ]; then
        log "Version mismatch: $current_version -> $version"
        
        # Update version
        update_version $version
        
        # Commit and push
        git add $PACKAGE_JSON
        git commit -m "chore: sync version to $version [skip ci]"
        git push origin $branch
        
        success "Synced version $version to $branch"
    else
        log "Version already up to date on $branch: $version"
    fi
}

# Main sync function
main() {
    log "Starting version synchronization"
    
    # Ensure we're on main branch
    local current_branch=$(git branch --show-current)
    if [ "$current_branch" != "$MAIN_BRANCH" ]; then
        error "Must be on $MAIN_BRANCH branch. Current branch: $current_branch"
    fi
    
    # Get version from main branch
    local main_version=$(get_version)
    log "Main branch version: $main_version"
    
    # Sync to each branch
    for branch in "${BRANCHES[@]}"; do
        sync_branch $branch $main_version
    done
    
    # Return to main branch
    git checkout $MAIN_BRANCH
    
    success "Version synchronization completed!"
    echo ""
    echo "📊 Version Summary:"
    echo "  Main: $main_version"
    for branch in "${BRANCHES[@]}"; do
        echo "  $branch: $main_version"
    done
}

# Run main function
main "$@"
