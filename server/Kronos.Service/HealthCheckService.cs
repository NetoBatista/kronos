using Kronos.Domain.Dto.HealthCheck;
using Kronos.Domain.Entity;
using Kronos.Domain.Interfaces.Repository;
using Kronos.Domain.Interfaces.Service;
using SimpleAutoMapper;

namespace Kronos.Service
{
    public class HealthCheckService(IHealthCheckRepository repository, IApplicationRepository applicationRepository) : IHealthCheckService
    {
        private readonly IHealthCheckRepository _repository = repository;
        private readonly IApplicationRepository _applicationRepository = applicationRepository;
        public async Task<HealthCheckResponseDTO> Create(HealthCheckCreateRequestDTO request)
        {
            var healthCheck = AutoMapper.Map<HealthCheck>(request)!;
            var response = await _repository.Create(healthCheck);
            return AutoMapper.Map<HealthCheckResponseDTO>(response)!;
        }

        public async Task<List<HealthCheckResponseDTO>> Get()
        {
            var response = await _repository.Get();
            return AutoMapper.Map<List<HealthCheckResponseDTO>>(response)!;
        }

        public async Task CheckAllApplications()
        {
            var applications = await _applicationRepository.Get();
            foreach (var application in applications)
            {
                if (string.IsNullOrEmpty(application.HealthCheck))
                {
                    continue;
                }
                if (!Uri.TryCreate(application.HealthCheck, UriKind.Absolute, out Uri? healthCheckUri))
                {
                    continue;
                }
                if (healthCheckUri == null)
                {
                    continue;
                }

                var client = new HttpClient();
                var response = await client.GetAsync(healthCheckUri);
                var healthCheck = new HealthCheck
                {
                    ApplicationId = application.Id,
                    Success = response.IsSuccessStatusCode
                };

                await _repository.Create(healthCheck);
            }
        }
    }
}
