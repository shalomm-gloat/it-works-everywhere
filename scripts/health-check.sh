#!/bin/bash

# Enhanced Health Check Script with Rollback Logic
# This script performs comprehensive health checks and can trigger rollbacks

set -e

# Configuration
HEALTH_ENDPOINT="http://localhost:3000/health"
MAX_RETRIES=5
RETRY_DELAY=30
ROLLBACK_THRESHOLD=3
CURRENT_VERSION=$(git describe --tags --abbrev=0 2>/dev/null || echo "unknown")
LOG_FILE="/tmp/health-check.log"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Health check function
perform_health_check() {
    local attempt=$1
    log "Health check attempt $attempt/$MAX_RETRIES"
    
    # Perform health check
    if curl -f -s "$HEALTH_ENDPOINT" > /dev/null; then
        log "✅ Health check PASSED"
        return 0
    else
        log "❌ Health check FAILED (attempt $attempt)"
        return 1
    fi
}

# Rollback function
trigger_rollback() {
    log "🚨 HEALTH CHECK FAILURES EXCEEDED THRESHOLD - TRIGGERING ROLLBACK"
    
    # Get previous version
    PREVIOUS_VERSION=$(git tag --sort=-version:refname | head -2 | tail -1)
    
    if [ -z "$PREVIOUS_VERSION" ]; then
        log "❌ No previous version found for rollback"
        return 1
    fi
    
    log "🔄 Rolling back from $CURRENT_VERSION to $PREVIOUS_VERSION"
    
    # In a real environment, this would:
    # 1. Stop current deployment
    # 2. Deploy previous version
    # 3. Verify health
    
    # Simulate rollback
    echo "🔄 ROLLBACK SIMULATION:"
    echo "  - Current version: $CURRENT_VERSION"
    echo "  - Rolling back to: $PREVIOUS_VERSION"
    echo "  - Stopping current deployment..."
    echo "  - Deploying previous version..."
    echo "  - Verifying health..."
    
    # Simulate successful rollback
    log "✅ Rollback completed successfully"
    
    # Send rollback notification
    send_notification "rollback" "$CURRENT_VERSION" "$PREVIOUS_VERSION"
    
    return 0
}

# Notification function
send_notification() {
    local type=$1
    local from_version=$2
    local to_version=$3
    
    case $type in
        "rollback")
            log "📢 SENDING ROLLBACK NOTIFICATION"
            echo "🚨 ROLLBACK EXECUTED"
            echo "  From: $from_version"
            echo "  To: $to_version"
            echo "  Reason: Health check failures"
            echo "  Time: $(date)"
            ;;
        "health_failure")
            log "📢 SENDING HEALTH FAILURE NOTIFICATION"
            echo "⚠️ HEALTH CHECK FAILURE"
            echo "  Version: $CURRENT_VERSION"
            echo "  Attempt: $attempt"
            echo "  Time: $(date)"
            ;;
    esac
}

# Main health check loop
main() {
    log "🏥 Starting enhanced health check for version $CURRENT_VERSION"
    
    local failures=0
    
    for attempt in $(seq 1 $MAX_RETRIES); do
        if perform_health_check $attempt; then
            log "✅ All health checks passed - deployment is healthy"
            return 0
        else
            failures=$((failures + 1))
            
            # Send notification for health failure
            send_notification "health_failure" "" ""
            
            # Check if we should trigger rollback
            if [ $failures -ge $ROLLBACK_THRESHOLD ]; then
                trigger_rollback
                return 1
            fi
            
            # Wait before next attempt
            if [ $attempt -lt $MAX_RETRIES ]; then
                log "⏳ Waiting $RETRY_DELAY seconds before next attempt..."
                sleep $RETRY_DELAY
            fi
        fi
    done
    
    log "❌ All health check attempts failed"
    return 1
}

# Run main function
main "$@"
