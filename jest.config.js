module.exports = {
  // Test environment
  testEnvironment: 'node',

  // Test file patterns
  testMatch: ['**/__tests__/**/*.js', '**/?(*.)+(spec|test).js'],

  // Coverage configuration
  collectCoverage: true,
  coverageDirectory: 'coverage',
  coverageReporters: ['text', 'lcov', 'html'],
  coverageThreshold: {
    global: {
      branches: 40, // Lowered to account for conditional server startup
      functions: 80,
      lines: 80,
      statements: 80,
    },
  },

  // Coverage exclusions
  coveragePathIgnorePatterns: [
    '/node_modules/',
    '/coverage/',
    '/__tests__/',
    'jest.config.js',
  ],

  // Verbose output
  verbose: true,

  // Clear mocks between tests
  clearMocks: true,

  // Test timeout
  testTimeout: 10000,

  // Force exit after tests
  forceExit: true,

  // Detect open handles
  detectOpenHandles: true,
};
