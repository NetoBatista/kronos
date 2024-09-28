using Kronos.Domain.Entity;
using Kronos.Domain.Interfaces.Repository;
using Microsoft.EntityFrameworkCore;

namespace Kronos.Repository
{
    public class ApplicationRepository(KronosContext context) : IApplicationRepository
    {
        private readonly KronosContext _context = context;

        public async Task<Application> Create(Application application)
        {
            application.CreatedAt = DateTime.UtcNow;
            application.Key = Guid.NewGuid();
            _context.Application.Add(application);
            await _context.SaveChangesAsync();
            return application;
        }

        public async Task<Application> Update(Application application)
        {
            var entity = _context.Application.AsNoTracking().FirstOrDefault(x => x.Id == application.Id);
            if (entity == null)
            {
                return application;
            }
            entity.Name = application.Name;
            entity.HealthCheck = application.HealthCheck;
            _context.Application.Update(entity);
            await _context.SaveChangesAsync();
            return entity;
        }

        public async Task Delete(Guid applicationId)
        {
            var entity = _context.Application.AsNoTracking()
                                             .Include(x => x.LogNavigation)
                                             .Include(x => x.HealthCheckNavigation)
                                             .FirstOrDefault(x => x.Id == applicationId);
            if (entity == null)
            {
                return;
            }
            _context.Application.Remove(entity);
            await _context.SaveChangesAsync();
        }

        public Task<List<Application>> Get()
        {
            return _context.Application.OrderBy(x => x.Name).ToListAsync();
        }

        public Task<Application?> GetByKey(Guid applicationKey)
        {
            return _context.Application.FirstOrDefaultAsync(x => x.Key == applicationKey);
        }
    }
}
