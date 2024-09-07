using Kronos.Domain.Dto.LogContent;

namespace Kronos.Domain.Interfaces.Service
{
    public interface ILogService
    {
        Task<LogResponseDTO?> Create(LogCreateRequestDTO request);
        Task<List<LogResponseDTO>> Get(LogSearchRequestDTO request);
    }
}
