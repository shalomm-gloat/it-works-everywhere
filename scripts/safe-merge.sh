#!/bin/bash

# Safe Merge Script
# Handles branch merges with conflict resolution and version synchronization

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
MAIN_BRANCH="main"
STAGING_BRANCH="staging"
DEVELOP_BRANCH="develop"

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
    if [ -f "package.json" ]; then
        node -p "require('./package.json').version"
    else
        error "package.json not found"
    fi
}

# Resolve package.json conflicts
resolve_package_conflicts() {
    log "Resolving package.json conflicts"
    
    # Always use the higher version number
    local version1=$(node -p "require('./package.json').version" 2>/dev/null || echo "0.0.0")
    local version2=$(node -p "require('./package.json.orig').version" 2>/dev/null || echo "0.0.0")
    
    # Compare versions using semver
    local higher_version=$(node -e "
        const semver = require('semver');
        const v1 = '$version1';
        const v2 = '$version2';
        console.log(semver.gt(v1, v2) ? v1 : v2);
    ")
    
    log "Using higher version: $higher_version"
    
    # Update package.json with higher version
    node -e "
        const fs = require('fs');
        const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));
        pkg.version = '$higher_version';
        fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2) + '\n');
    "
    
    # Add resolved package.json
    git add package.json
    
    success "Package.json conflicts resolved"
}

# Safe merge function
safe_merge() {
    local source_branch=$1
    local target_branch=$2
    
    log "Merging $source_branch into $target_branch"
    
    # Ensure we're on target branch
    git checkout $target_branch
    git pull origin $target_branch
    
    # Get versions before merge
    local target_version=$(get_version)
    log "Target branch version: $target_version"
    
    # Attempt merge
    if git merge $source_branch --no-edit; then
        success "Merge successful"
    else
        warning "Merge conflicts detected, attempting resolution"
        
        # Check if package.json has conflicts
        if git diff --name-only --diff-filter=U | grep -q "package.json"; then
            resolve_package_conflicts
        fi
        
        # Continue merge
        git merge --continue
        
        success "Merge conflicts resolved"
    fi
    
    # Get version after merge
    local new_version=$(get_version)
    log "Version after merge: $new_version"
    
    # Push changes
    git push origin $target_branch
    
    success "Successfully merged $source_branch into $target_branch"
}

# Progressive deployment merge
progressive_merge() {
    local feature_branch=$1
    
    log "Starting progressive deployment merge"
    
    # 1. Merge to develop
    log "Step 1: Merging to develop"
    safe_merge $feature_branch $DEVELOP_BRANCH
    
    # 2. Merge develop to staging
    log "Step 2: Merging develop to staging"
    safe_merge $DEVELOP_BRANCH $STAGING_BRANCH
    
    # 3. Merge staging to main
    log "Step 3: Merging staging to main"
    safe_merge $STAGING_BRANCH $MAIN_BRANCH
    
    success "Progressive deployment merge completed!"
    
    echo ""
    echo "🚀 Deployment Flow:"
    echo "  $feature_branch → $DEVELOP_BRANCH → $STAGING_BRANCH → $MAIN_BRANCH"
    echo ""
    echo "📊 Final Version: $(get_version)"
}

# Show usage
show_usage() {
    echo "Usage: $0 [COMMAND] [OPTIONS]"
    echo ""
    echo "Commands:"
    echo "  merge <source> <target>     Merge source branch into target branch"
    echo "  progressive <feature>       Progressive deployment merge"
    echo "  help                        Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 merge feature/new-feature develop"
    echo "  $0 merge develop staging"
    echo "  $0 merge staging main"
    echo "  $0 progressive feature/new-feature"
}

# Main script logic
case "${1:-help}" in
    "merge")
        if [ $# -ne 3 ]; then
            error "Usage: $0 merge <source> <target>"
        fi
        safe_merge "$2" "$3"
        ;;
    "progressive")
        if [ $# -ne 2 ]; then
            error "Usage: $0 progressive <feature-branch>"
        fi
        progressive_merge "$2"
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
