using Kronos.Domain.Configuration;
using Kronos.Domain.Entity;
using Kronos.Domain.Interfaces.Repository;
using Kronos.Domain.Interfaces.Service;
using Kronos.Repository;
using Kronos.Service;
using Microsoft.EntityFrameworkCore;

namespace Kronos.Extension
{
    public static class InjectDependencyExtension
    {
        public static void InjectDependency(this IServiceCollection services)
        {
            InjectServices(services);
            InjectRepository(services);
            InjectDataBase(services);
            InjectHostedService(services);
        }

        private static void InjectHostedService(IServiceCollection services)
        {
            services.AddHostedService<HostedService>();
        }

        private static void InjectDataBase(IServiceCollection services)
        {
            var connectionString = KronosContextConfiguration.ConnectionString;
            services.AddDbContext<KronosContext>(options =>
            {
                options.UseNpgsql(connectionString!);
                options.UseQueryTrackingBehavior(QueryTrackingBehavior.NoTracking);
            }, ServiceLifetime.Transient);
        }

        private static void InjectRepository(IServiceCollection services)
        {
            services.AddTransient<IApplicationRepository, ApplicationRepository>();
            services.AddTransient<IHealthCheckRepository, HealthCheckRepository>();
            services.AddTransient<ILogRepository, LogRepository>();
        }

        private static void InjectServices(IServiceCollection services)
        {
            services.AddTransient<IApplicationService, ApplicationService>();
            services.AddTransient<IHealthCheckService, HealthCheckService>();
            services.AddTransient<ILogService, LogService>();
        }
    }
}
