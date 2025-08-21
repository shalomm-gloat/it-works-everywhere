module.exports = {
  env: {
    node: true,
    es2021: true,
    jest: true,
  },
  extends: [
    'eslint:recommended',
    'prettier', // Disables ESLint rules that conflict with Prettier
  ],
  plugins: ['prettier'],
  parserOptions: {
    ecmaVersion: 2021,
    sourceType: 'module',
  },
  rules: {
    // Prettier integration
    'prettier/prettier': 'error',

    // Code quality rules
    'no-unused-vars': ['error', { argsIgnorePattern: '^_' }],
    'no-console': 'warn', // Allow console.log for now, but warn
    'no-debugger': 'error',
    'no-alert': 'error',

    // Best practices
    eqeqeq: ['error', 'always'],
    curly: ['error', 'all'],
    'no-eval': 'error',
    'no-implied-eval': 'error',
    'no-new-func': 'error',

    // Security
    'no-var': 'error',
    'prefer-const': 'error',

    // Node.js specific
    'no-process-exit': 'error',
    'no-path-concat': 'error',
  },
  ignorePatterns: ['node_modules/', 'coverage/', '*.min.js', 'dist/', 'build/'],
};
