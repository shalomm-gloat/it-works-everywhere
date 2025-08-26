#!/usr/bin/env python3
"""
YAML validation script for GitHub Actions workflows and custom actions.
"""

import yaml
import sys
import os
from pathlib import Path

def validate_yaml_file(file_path, required_fields, file_type):
    """Validate a YAML file for required fields."""
    try:
        with open(file_path, 'r') as f:
            data = yaml.safe_load(f)
        
        if not data:
            print(f'❌ Empty or invalid YAML file: {file_path}')
            return False
        
        for field in required_fields:
            if field not in data:
                print(f'❌ Missing required field "{field}" in {file_type}: {file_path}')
                return False
        
        print(f'✅ {file_type} structure is valid: {file_path}')
        return True
        
    except Exception as e:
        print(f'❌ Validation failed for {file_path}: {e}')
        return False

def main():
    """Main validation function."""
    print("🔍 Validating GitHub Actions syntax...")
    
    # Validate workflow files
    workflow_dir = Path('.github/workflows')
    if workflow_dir.exists():
        for workflow_file in workflow_dir.glob('*.yml'):
            print(f"Validating workflow structure: {workflow_file}")
            if not validate_yaml_file(workflow_file, ['on', 'jobs'], 'workflow'):
                sys.exit(1)
    
    # Validate custom action files
    actions_dir = Path('.github/actions')
    if actions_dir.exists():
        for action_file in actions_dir.rglob('action.yml'):
            print(f"Validating action structure: {action_file}")
            if not validate_yaml_file(action_file, ['name', 'runs'], 'action'):
                sys.exit(1)
    
    print("✅ All GitHub Actions validations passed!")

if __name__ == '__main__':
    main()
