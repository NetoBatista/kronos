using Kronos.Domain.Dto.Application;
using Kronos.Domain.Entity;
using Kronos.Domain.Interface.Service;
using Kronos.Domain.Interfaces.Repository;
using SimpleAutoMapper;

namespace Kronos.Service
{
    public class ApplicationService : IApplicationService
    {
        private readonly IApplicationRepository _repository;
        public ApplicationService(IApplicationRepository repository)
        {
            _repository = repository;
        }

        public async Task<ApplicationResponseDTO> Create(ApplicationCreateRequestDTO request)
        {
            var application = AutoMapper.Map<Application>(request)!;
            var response = await _repository.Create(application);
            return AutoMapper.Map<ApplicationResponseDTO>(response)!;
        }

        public Task Delete(Guid applicationId) => _repository.Delete(applicationId);

        public async Task<List<ApplicationResponseDTO>> Get()
        {
            var response = await _repository.Get();
            return AutoMapper.Map<List<ApplicationResponseDTO>>(response)!;
        }

        public async Task<ApplicationResponseDTO> Update(ApplicationUpdateRequestDTO request)
        {
            var application = AutoMapper.Map<Application>(request)!;
            var response = await _repository.Update(application);
            return AutoMapper.Map<ApplicationResponseDTO>(response)!;
        }
    }
}
