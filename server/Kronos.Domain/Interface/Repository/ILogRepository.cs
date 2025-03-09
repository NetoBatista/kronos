using Kronos.Domain.Dto.LogContent;
using Kronos.Domain.Dto.Statistic;
using Kronos.Domain.Entity;

namespace Kronos.Domain.Interfaces.Repository
{
    public interface ILogRepository
    {
        Task<Log> Create(Log log);
        Task<List<Log>> Get(LogSearchRequestDTO request);
        Task<List<Log>> Get(StatisticRequestDto request);
    }
}
