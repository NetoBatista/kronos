using Kronos.Domain.Dto.HealthCheck;

namespace Kronos.Service.Interface
{
    public interface IHealthCheckService
    {
        Task<List<HealthCheckResponseDTO>> Get();
        Task<bool> CheckAllApplications();
    }
}
