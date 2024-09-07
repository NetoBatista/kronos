using Kronos.Domain.Dto.Application;

namespace Kronos.Service.Interface
{
    public interface IApplicationService
    {
        Task<ApplicationResponseDTO?> Create(ApplicationCreateRequestDTO request);
        Task<ApplicationResponseDTO?> Update(ApplicationUpdateRequestDTO request);
        Task<bool> Delete(Guid applicationId);
        Task<List<ApplicationResponseDTO>> Get();
    }
}
