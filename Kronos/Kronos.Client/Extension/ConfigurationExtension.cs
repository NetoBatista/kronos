using Kronos.Domain.Configuration;

namespace Kronos.Client.Extension
{
    public static class ConfigurationExtension
    {
        public static void ConfigureKronosAPI(IConfiguration configuration)
        {
            KronosConfigurationAPI.BaseAddress = configuration.GetSection("KronosApi").Value ?? string.Empty;
        }
    }
}
