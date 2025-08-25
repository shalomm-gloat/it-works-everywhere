# Test Quality Action

This action runs comprehensive testing and quality gates to ensure code quality before deployment.

## Purpose

Performs all necessary quality checks including linting, testing, security audits, and health checks to validate code before it can be deployed.

## How it works

The action sets up the Node.js environment and runs multiple quality checks in sequence:

1. **Dependency Installation**: Installs all required packages
2. **Linting**: Runs ESLint to check code quality and style
3. **Testing**: Executes Jest tests with coverage reporting
4. **Security Audit**: Runs npm audit to check for vulnerabilities
5. **Health Check**: Validates application health using the test script

## Inputs

This action has no inputs - it uses the repository's package.json and test configuration.

## Outputs

This action has no outputs - it succeeds or fails based on quality gate results.

## Usage

```yaml
- name: Run tests and quality gates
  uses: ./.github/actions/test-quality
```

## Quality Gates

### Linting
- **Tool**: ESLint
- **Configuration**: `.eslintrc.js` or `package.json`
- **Failure**: Any linting errors will fail the workflow

### Testing
- **Tool**: Jest
- **Coverage**: Generates coverage reports
- **Failure**: Any test failures will fail the workflow

### Security
- **Tool**: npm audit
- **Threshold**: No moderate or higher vulnerabilities
- **Failure**: Security vulnerabilities will fail the workflow

### Health Check
- **Tool**: Custom test script (`test.sh`)
- **Validation**: Application responds correctly
- **Failure**: Health check failures will fail the workflow

## Best Practices

1. **Fail Fast**: Any quality gate failure stops the pipeline
2. **Comprehensive Coverage**: Tests should cover critical functionality
3. **Security First**: No deployment with known vulnerabilities
4. **Consistent Standards**: Linting ensures code consistency

## Dependencies

- Node.js 18+
- npm or yarn package manager
- ESLint configuration
- Jest test framework
- Custom test scripts
