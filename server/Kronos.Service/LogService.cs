using Kronos.Domain.Dto.LogContent;
using Kronos.Domain.Entity;
using Kronos.Domain.Interfaces.Repository;
using Kronos.Domain.Interfaces.Service;
using SimpleAutoMapper;

namespace Kronos.Service
{
    public class LogService(ILogRepository repository, IApplicationRepository applicationRepository) : ILogService
    {
        private readonly ILogRepository _repository = repository;
        private readonly IApplicationRepository _applicationRepository = applicationRepository;
        public async Task<LogResponseDTO?> Create(LogCreateRequestDTO request)
        {
            var application = await _applicationRepository.GetByKey(request.ApplicationKey);
            if (application == null)
            {
                return null;
            }

            var log = AutoMapper.Map<Log>(request)!;
            log.ApplicationId = application.Id;

            var response = await _repository.Create(log);
            return AutoMapper.Map<LogResponseDTO>(response)!;
        }

        public async Task<List<LogResponseDTO>> Get(LogSearchRequestDTO request)
        {
            var response = await _repository.Get(request);
            return AutoMapper.Map<List<LogResponseDTO>>(response)!;
        }
    }
}
