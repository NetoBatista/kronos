using Kronos.Domain.Dto.HealthCheck;

namespace Kronos.Domain.Interface.Service
{
    public interface IHealthCheckService
    {
        Task<List<HealthCheckResponseDTO>> Get();
        Task<HealthCheckResponseDTO> Create(HealthCheckCreateRequestDTO request);
        Task CheckAllApplications();
    }
}
