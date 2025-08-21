module.exports = {
  testEnvironment: 'node',
  testMatch: ['**/__tests__/**/*.js'],
  collectCoverage: true,
  coverageDirectory: 'coverage',
  coverageThreshold: {
    global: {
      branches: 30,
      functions: 30,
      lines: 50,
      statements: 50,
    },
  },
  coveragePathIgnorePatterns: ['/node_modules/', '/coverage/'],
  verbose: true,
  forceExit: true,
};
