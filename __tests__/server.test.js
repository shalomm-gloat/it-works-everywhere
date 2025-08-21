describe('Simple Health Check Test', () => {
  it('should return health check message', (done) => {
    // Simple test using curl since the app doesn't export properly
    const { exec } = require('child_process');
    
    // Start server in background
    const server = exec('node server.js');
    
    // Wait a bit for server to start, then test
    setTimeout(() => {
      exec('curl -s http://localhost:3000/health', (error, stdout, _stderr) => {
        if (error) {
          server.kill();
          return done(error);
        }
        
        expect(stdout).toContain('Still working');
        expect(stdout).toContain('machine');
        
        server.kill();
        done();
      });
    }, 1000);
  });
}); 