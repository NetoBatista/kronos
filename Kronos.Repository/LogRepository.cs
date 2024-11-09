using Kronos.Domain.Dto.LogContent;
using Kronos.Domain.Entity;
using Kronos.Domain.Interfaces.Repository;
using Microsoft.EntityFrameworkCore;

namespace Kronos.Repository
{
    public class LogRepository(KronosContext context) : ILogRepository
    {
        private readonly KronosContext _context = context;
        public async Task<Log> Create(Log log)
        {
            log.CreatedAt = DateTime.UtcNow;
            _context.Log.Add(log);
            await _context.SaveChangesAsync();
            return log;
        }

        public Task<List<Log>> Get(LogSearchRequestDTO request)
        {
            var query = _context.Log.AsQueryable();
            if (request.ApplicationId != null)
            {
                query = query.Where(x => x.ApplicationId == request.ApplicationId);
            }
            if (!string.IsNullOrEmpty(request.Content))
            {
                query = query.Where(x => x.Content.ToUpper().Contains(request.Content.ToUpper()));
            }
            if (!string.IsNullOrEmpty(request.Type))
            {
                query = query.Where(x => x.Type == request.Type);
            }
            if (request.StartDate != null)
            {
                var startDate = new DateTime(request.StartDate.Value.Year, request.StartDate.Value.Month, request.StartDate.Value.Day, 0, 0, 0, DateTimeKind.Utc);
                query = query.Where(x => x.CreatedAt >= startDate);
            }
            if (request.EndDate != null)
            {
                var endDate = new DateTime(request.EndDate.Value.Year, request.EndDate.Value.Month, request.EndDate.Value.Day, 23, 59, 59, DateTimeKind.Utc);
                query = query.Where(x => x.CreatedAt <= endDate);
            }
            return query.OrderByDescending(x => x.CreatedAt).Take(100).ToListAsync();
        }
    }
}
