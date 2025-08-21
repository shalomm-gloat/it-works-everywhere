const express = require('express');
const app = express();

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Metrics tracking
let requestCount = 0;
const startTime = Date.now();

// Middleware to track requests
app.use((req, res, next) => {
  requestCount++;
  const start = Date.now();

  res.on('finish', () => {
    const duration = Date.now() - start;
    console.log(
      `${req.method} ${req.path} - ${res.statusCode} - ${duration}ms`
    );
  });

  next();
});

// Health check endpoint
app.get('/health', (req, res) => {
  const uptime = Date.now() - startTime;
  res.status(200).json({
    status: 'healthy',
    message: 'Still working... on *my* machine 🧃',
    uptime: `${Math.floor(uptime / 1000)}s`,
    timestamp: new Date().toISOString(),
    version: process.env.npm_package_version || '1.0.0',
  });
});

// Metrics endpoint (Prometheus format)
app.get('/metrics', (req, res) => {
  const uptime = Date.now() - startTime;
  const metrics = [
    `# HELP http_requests_total Total number of HTTP requests`,
    `# TYPE http_requests_total counter`,
    `http_requests_total ${requestCount}`,
    `# HELP http_server_uptime_seconds Server uptime in seconds`,
    `# TYPE http_server_uptime_seconds gauge`,
    `http_server_uptime_seconds ${Math.floor(uptime / 1000)}`,
    `# HELP http_server_info Information about the server`,
    `# TYPE http_server_info gauge`,
    `http_server_info{version="${process.env.npm_package_version || '1.0.0'}"} 1`,
  ].join('\n');

  res.set('Content-Type', 'text/plain');
  res.status(200).send(metrics);
});

// Root endpoint
app.get('/', (req, res) => {
  res.json({
    message: 'Welcome to It Works On My Machine API',
    version: process.env.npm_package_version || '1.0.0',
    endpoints: {
      health: '/health',
      metrics: '/metrics',
    },
  });
});

// Error handling middleware
app.use((err, req, res, _next) => {
  console.error('Error:', err.stack);
  res.status(500).json({
    error: 'Something went wrong!',
    message:
      process.env.NODE_ENV === 'production'
        ? 'Internal server error'
        : err.message,
  });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({
    error: 'Not found',
    message: `Route ${req.method} ${req.path} not found`,
  });
});

// Only start the server if this file is run directly
if (require.main === module) {
  const port = process.env.PORT || 3000;
  app.listen(port, () => {
    console.log(`🚀 Server is running on http://localhost:${port}`);
    console.log(`📊 Health check: http://localhost:${port}/health`);
    console.log(`📈 Metrics: http://localhost:${port}/metrics`);
    console.log(`⏰ Started at: ${new Date().toISOString()}`);
  });
}

module.exports = app; // Export for testing
