using Azure.Messaging.ServiceBus;
using Kronos.Domain.Configuration;
using Kronos.Domain.Dto.LogContent;
using Kronos.Domain.Interface.Service;
using System.Text.Json;

namespace Kronos.Service
{
    public class ServiceBusHostedService : BackgroundService
    {
        private readonly IServiceProvider _serviceProvider;

        private readonly ILogger<ServiceBusHostedService> _logger;

        private readonly ILogService _logService;

        JsonSerializerOptions jsonSerializerOptions = new JsonSerializerOptions
        {
            PropertyNamingPolicy = JsonNamingPolicy.CamelCase
        };

        public ServiceBusHostedService(ILogger<ServiceBusHostedService> logger, IServiceProvider serviceProvider)
        {
            _logger = logger;
            _serviceProvider = serviceProvider;
            var scope = _serviceProvider.CreateScope();
            _logService = scope.ServiceProvider.GetRequiredService<ILogService>();
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            if (string.IsNullOrEmpty(KronosQueueConfiguration.ConnectionString) ||
                string.IsNullOrEmpty(KronosQueueConfiguration.QueueName))
            {
                return;
            }

            try
            {
                await Task.Delay(1000, stoppingToken);
                _logger.LogInformation("Worker running at: {time}", DateTimeOffset.Now);
                await ConfigureProcessor();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.ToString());
                await ExecuteAsync(stoppingToken);
            }
        }

        private async Task ConfigureProcessor()
        {
            var clientOptions = new ServiceBusClientOptions()
            {
                TransportType = ServiceBusTransportType.AmqpWebSockets
            };
            var client = new ServiceBusClient(KronosQueueConfiguration.ConnectionString, clientOptions);

            var processor = client.CreateProcessor(KronosQueueConfiguration.QueueName, new ServiceBusProcessorOptions());

            try
            {
                processor.ProcessMessageAsync += MessageHandler;
                processor.ProcessErrorAsync += ErrorHandler;
                await processor.StartProcessingAsync();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.ToString());
                throw;
            }
        }

        private async Task MessageHandler(ProcessMessageEventArgs args)
        {
            var body = args.Message.Body.ToString();

            _logger.LogInformation("Log received {body}", body);

            var request = JsonSerializer.Deserialize<LogCreateRequestDTO>(body, jsonSerializerOptions);

            if (request == null)
            {
                await args.DeadLetterMessageAsync(args.Message);
                return;
            }

            await _logService.Create(request);

            await args.CompleteMessageAsync(args.Message);
        }

        private Task ErrorHandler(ProcessErrorEventArgs args)
        {
            Console.WriteLine(args.Exception.ToString());
            return Task.CompletedTask;
        }

    }
}
