using Kronos.Provider;
using Kronos.Service;
using Kronos.Service.Interface;

namespace Kronos.Extension
{
    public static class InjectDependencyExtension
    {
        public static void InjectDependency(this IServiceCollection services)
        {
            services.AddScoped<DialogProvider>();

            services.AddTransient<IApplicationService, ApplicationService>();
            services.AddTransient<IHealthCheckService, HealthCheckService>();
            services.AddTransient<ILogService, LogService>();
        }
    }
}
