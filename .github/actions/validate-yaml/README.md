# Validate YAML Syntax Action

Validates YAML syntax for GitHub Actions workflows and custom actions to catch syntax errors early in the CI/CD pipeline.

## Features

- **YAML Syntax Validation**: Ensures all YAML files are syntactically correct
- **Workflow Structure Validation**: Checks for required fields in workflow files (`on`, `jobs`)
- **Custom Action Validation**: Validates custom action structure (`name`, `runs`)
- **Comprehensive Coverage**: Validates all workflow and action files automatically

## Usage

```yaml
- name: Validate YAML
  uses: ./.github/actions/validate-yaml
```

## What It Validates

### Workflow Files
- `.github/workflows/ci-cd.yml`
- `.github/workflows/rollback.yml`
- All other `.yml` files in `.github/workflows/`

### Custom Actions
- All `action.yml` files in `.github/actions/*/`

### Validation Checks
1. **YAML Syntax**: Ensures files can be parsed as valid YAML
2. **Required Fields**: 
   - Workflows: `on`, `jobs`
   - Actions: `name`, `runs`
3. **Structure**: Validates GitHub Actions specific structure

## Benefits

- **Early Error Detection**: Catches YAML syntax errors before deployment
- **Consistency**: Ensures all workflow files follow proper structure
- **Maintainability**: Helps prevent broken workflows from being merged
- **Developer Experience**: Provides clear error messages for debugging

## Error Examples

The action will fail with clear error messages for issues like:

```
❌ Missing required field: on
❌ Missing required field: jobs
❌ Validation failed: [Errno 2] No such file or directory
```

## Integration

This action is automatically run in the test job of the CI/CD pipeline to ensure all YAML files are valid before any deployment attempts.
