using Kronos.Domain.Configuration;
using Kronos.Domain.Dto.HealthCheck;
using Kronos.Service.Interface;
using System.Net.Http.Json;

namespace Kronos.Service
{
    public class HealthCheckService : IHealthCheckService
    {
        private readonly HttpClient _httpClient;
        private readonly string _requestUri = "api/v1/HealthCheck";

        public HealthCheckService()
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
