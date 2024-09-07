using Kronos.Domain.Entity;

namespace Kronos.Domain.Interfaces.Repository
{
    public interface IHealthCheckRepository
    {
        Task<HealthCheck> Create(HealthCheck healthCheck);
        Task<List<HealthCheck>> Get();
    }
}
