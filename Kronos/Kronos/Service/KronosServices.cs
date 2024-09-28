namespace Kronos.Service
{
    public static class KronosServices
    {
        public static void StartServices(WebApplication app)
        {
            _ = Task.Run(async () =>
            {
                using var scope = app.Services.CreateScope();
                var hostedService = scope.ServiceProvider.GetRequiredService<ServiceBusHostedService>();
                await hostedService.StartAsync(CancellationToken.None);
            });

            _ = Task.Run(async () =>
            {
                using var scope = app.Services.CreateScope();
                var hostedService = scope.ServiceProvider.GetRequiredService<HealthCheckHostedService>();
                await hostedService.StartAsync(CancellationToken.None);
            });
        }
    }
}
