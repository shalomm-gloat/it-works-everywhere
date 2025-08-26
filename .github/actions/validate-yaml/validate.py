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
            content = f.read()
            data = yaml.safe_load(content)
        
        if not data:
            print(f'❌ Empty or invalid YAML file: {file_path}')
            return False
        
        # Debug: print the actual keys found
        actual_keys = list(data.keys())
        print(f'🔍 Found keys in {file_path}: {actual_keys}')
        
        # Check if 'on' is being interpreted as True (common YAML issue)
        if True in actual_keys and 'on' not in actual_keys:
            print(f'⚠️  Warning: "on" field is being interpreted as True in {file_path}')
            print(f'   This might be due to YAML syntax issues or hidden characters')
            # For now, let's be more lenient and accept True as 'on'
            if 'on' in required_fields:
                required_fields = [field if field != 'on' else True for field in required_fields]
        
        for field in required_fields:
            if field not in data:
                print(f'❌ Missing required field "{field}" in {file_type}: {file_path}')
                print(f'   Expected: {required_fields}')
                print(f'   Found: {actual_keys}')
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
