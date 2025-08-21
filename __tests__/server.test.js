const request = require('supertest');
const app = require('../server');

describe('Server API Tests', () => {
  let server;
  let testPort = 3001;

  beforeAll(async () => {
    // Find an available port
    const net = require('net');
    const findAvailablePort = startPort => {
      return new Promise(resolve => {
        const server = net.createServer();
        server.listen(startPort, () => {
          const { port } = server.address();
          server.close(() => resolve(port));
        });
        server.on('error', () => {
          resolve(findAvailablePort(startPort + 1));
        });
      });
    };

    testPort = await findAvailablePort(testPort);
    server = app.listen(testPort);
  });

  afterAll(done => {
    if (server) {
      server.close(done);
    } else {
      done();
    }
  });

  describe('GET /', () => {
    it('should return welcome message and API info', async () => {
      const response = await request(app).get('/').expect(200);

      expect(response.body).toHaveProperty('message');
      expect(response.body).toHaveProperty('version');
      expect(response.body).toHaveProperty('endpoints');
      expect(response.body.endpoints).toHaveProperty('health');
      expect(response.body.endpoints).toHaveProperty('metrics');
    });
  });

  describe('GET /health', () => {
    it('should return healthy status', async () => {
      const response = await request(app).get('/health').expect(200);

      expect(response.body).toHaveProperty('status', 'healthy');
      expect(response.body).toHaveProperty('message');
      expect(response.body).toHaveProperty('uptime');
      expect(response.body).toHaveProperty('timestamp');
      expect(response.body).toHaveProperty('version');
    });

    it('should include uptime in response', async () => {
      const response = await request(app).get('/health').expect(200);

      expect(response.body.uptime).toMatch(/^\d+s$/);
    });

    it('should return valid timestamp', async () => {
      const response = await request(app).get('/health').expect(200);

      const timestamp = new Date(response.body.timestamp);
      expect(timestamp.getTime()).toBeGreaterThan(0);
    });
  });

  describe('GET /metrics', () => {
    it('should return Prometheus format metrics', async () => {
      const response = await request(app).get('/metrics').expect(200);

      expect(response.headers['content-type']).toContain('text/plain');
      expect(response.text).toContain('http_requests_total');
      expect(response.text).toContain('http_server_uptime_seconds');
      expect(response.text).toContain('http_server_info');
    });

    it('should include request counter', async () => {
      const response = await request(app).get('/metrics').expect(200);

      expect(response.text).toMatch(/http_requests_total \d+/);
    });

    it('should include uptime metric', async () => {
      const response = await request(app).get('/metrics').expect(200);

      expect(response.text).toMatch(/http_server_uptime_seconds \d+/);
    });
  });

  describe('Error Handling', () => {
    it('should return 404 for unknown routes', async () => {
      const response = await request(app).get('/unknown-route').expect(404);

      expect(response.body).toHaveProperty('error', 'Not found');
      expect(response.body).toHaveProperty('message');
    });

    it('should handle malformed JSON gracefully', async () => {
      const response = await request(app)
        .post('/')
        .set('Content-Type', 'application/json')
        .send('invalid json')
        .expect(500); // Express returns 500 for JSON parsing errors

      expect(response.body).toHaveProperty('error');
    });
  });

  describe('Request Tracking', () => {
    it('should increment request counter', async () => {
      // Get initial metrics
      const initialResponse = await request(app).get('/metrics').expect(200);

      const initialMatch = initialResponse.text.match(
        /http_requests_total (\d+)/
      );
      const initialCount = parseInt(initialMatch[1], 10);

      // Make a request
      await request(app).get('/health').expect(200);

      // Get updated metrics
      const updatedResponse = await request(app).get('/metrics').expect(200);

      const updatedMatch = updatedResponse.text.match(
        /http_requests_total (\d+)/
      );
      const updatedCount = parseInt(updatedMatch[1], 10);

      expect(updatedCount).toBeGreaterThan(initialCount);
    });
  });
});
