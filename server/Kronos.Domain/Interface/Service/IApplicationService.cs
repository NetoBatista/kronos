using Kronos.Domain.Dto.Application;

namespace Kronos.Domain.Interface.Service
{
    public interface IApplicationService
    {
        Task<ApplicationResponseDTO> Create(ApplicationCreateRequestDTO request);
        Task<ApplicationResponseDTO> Update(ApplicationUpdateRequestDTO request);
        Task Delete(Guid applicationId);
        Task<List<ApplicationResponseDTO>> Get();
    }
}
