using Kronos.Domain.Interfaces.Service;
using System.Text.Json;

namespace Kronos.Service
{
    public class HealthCheckHostedService : BackgroundService
    {
        private readonly IServiceProvider _serviceProvider;

        private readonly ILogger<HealthCheckHostedService> _logger;

        private readonly IHealthCheckService _healthCheck;

        JsonSerializerOptions jsonSerializerOptions = new JsonSerializerOptions
        {
            PropertyNamingPolicy = JsonNamingPolicy.CamelCase
        };

        public HealthCheckHostedService(ILogger<HealthCheckHostedService> logger, IServiceProvider serviceProvider)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            var scope = _serviceProvider.CreateScope();
            _healthCheck = scope.ServiceProvider.GetRequiredService<IHealthCheckService>();
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            await Task.Delay(1000, stoppingToken);
            while (!stoppingToken.IsCancellationRequested)
            {
                try
                {
                    await _healthCheck.CheckAllApplications();
                    _logger.LogInformation("Worker running at: {time}", DateTimeOffset.Now);
                }
                catch (Exception ex)
                {
                    _logger.LogError("Error at: {time} \n{log}", DateTimeOffset.Now, ex.ToString());
                }
                await Task.Delay(12 * 60 * 60 * 1000, stoppingToken); //12 hours
            }
        }
    }
}
