using Kronos.Domain.Dto.HealthCheck;
using Kronos.Domain.Entity;
using Kronos.Domain.Interface.Service;
using Kronos.Domain.Interfaces.Repository;
using SimpleAutoMapper;

namespace Kronos.Service
{
    public class HealthCheckService : IHealthCheckService
    {
        private readonly IHealthCheckRepository _repository;
        private readonly IApplicationRepository _applicationRepository;
        private readonly HttpClient _httpClient;

        public HealthCheckService(IHealthCheckRepository repository, IApplicationRepository applicationRepository)
        {
            _repository = repository;
            _applicationRepository = applicationRepository;
            _httpClient = new HttpClient();
        }

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
                
                var response = await _httpClient.GetAsync(healthCheckUri);
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
