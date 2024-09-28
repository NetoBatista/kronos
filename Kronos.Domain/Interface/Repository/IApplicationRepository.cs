using Kronos.Domain.Entity;

namespace Kronos.Domain.Interfaces.Repository
{
    public interface IApplicationRepository
    {
        Task<Application> Create(Application application);
        Task<Application> Update(Application application);
        Task Delete(Guid applicationId);
        Task<List<Application>> Get();
        Task<Application?> GetByKey(Guid applicationKey);
    }
}
