using Kronos.Domain.Entity;
using Kronos.Domain.Interfaces.Repository;
using Microsoft.EntityFrameworkCore;

namespace Kronos.Repository
{
    public class HealthCheckRepository(KronosContext context) : IHealthCheckRepository
    {
        private readonly KronosContext _context = context;

        public async Task<HealthCheck> Create(HealthCheck healthCheck)
        {
            healthCheck.CreatedAt = DateTime.UtcNow;
            _context.Healthcheck.Add(healthCheck);
            await _context.SaveChangesAsync();
            return healthCheck;
        }

        public Task<List<HealthCheck>> Get()
        {
            return _context.Healthcheck.OrderByDescending(x => x.CreatedAt).Take(50).ToListAsync();
        }
    }
}
