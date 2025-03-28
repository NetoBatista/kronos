﻿using Kronos.Domain.Configuration;

namespace Kronos.Extension
{
    public static class ConfigurationExtension
    {
        public static void ConfigurationKronos(this IConfiguration configuration)
        {
            ConfigureKronosContext(configuration);
            ConfigureKronosQueue(configuration);
        }

        private static void ConfigureKronosContext(IConfiguration configuration)
        {
            var connectionString = Environment.GetEnvironmentVariable("CONNECTION_STRING");
            connectionString ??= configuration.GetSection("Database").GetSection("ConnectionString").Value;
            KronosContextConfiguration.ConnectionString = connectionString ?? string.Empty;
        }

        private static void ConfigureKronosQueue(IConfiguration configuration)
        {
            var connectionString = Environment.GetEnvironmentVariable("SERVICEBUS_CONNECTION_STRING");
            connectionString ??= configuration.GetSection("Queue").GetSection("ServiceBus").GetSection("ConnectionString").Value;

            var queueName = Environment.GetEnvironmentVariable("SERVICEBUS_QUEUE");
            queueName ??= configuration.GetSection("Queue").GetSection("ServiceBus").GetSection("Name").Value;

            KronosQueueConfiguration.ConnectionString = connectionString ?? string.Empty;
            KronosQueueConfiguration.QueueName = queueName ?? string.Empty;
        }
    }
}
