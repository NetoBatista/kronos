using Kronos.Domain.Configuration;
using Kronos.Domain.Dto.HealthCheck;
using System.Net.Http.Json;

namespace Kronos.Client.Handler
{
    public class HealthCheckHandler
    {
        private readonly HttpClient _httpClient;
        private readonly string _requestUri = "api/v1/HealthCheck";

        public HealthCheckHandler()
        {
            _httpClient = new HttpClient
            {
                BaseAddress = new Uri(KronosConfigurationAPI.BaseAddress)
            };
        }

        public async Task<bool> CheckAllApplications()
        {
            var response = await _httpClient.PostAsync($"{_requestUri}/Applications", null);
            return response.IsSuccessStatusCode;
        }

        public async Task<List<HealthCheckResponseDTO>> Get()
        {
            var response = await _httpClient.GetAsync(_requestUri);
            if (!response.IsSuccessStatusCode)
            {
                return [];
            }
            var result = await response.Content.ReadFromJsonAsync<List<HealthCheckResponseDTO>>();
            return result ?? [];
        }
    }
}
