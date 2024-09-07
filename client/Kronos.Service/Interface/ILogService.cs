using Kronos.Domain.Dto.LogContent;

namespace Kronos.Service.Interface
{
    public interface ILogService
    {
        Task<List<LogResponseDTO>> Get(LogSearchRequestDTO request);
    }
}
