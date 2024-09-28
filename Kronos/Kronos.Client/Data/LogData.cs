using Kronos.Domain.Configuration;
using Kronos.Domain.Dto.LogContent;
using Kronos.Domain.Helper;
using System.Net.Http.Json;

namespace Kronos.Client.Data
{
    public class LogData
    {
        private readonly HttpClient _httpClient;
        private readonly string _requestUri = "api/v1/Log";

        public LogData()
        {
            _httpClient = new HttpClient
            {
                BaseAddress = new Uri(KronosConfigurationAPI.BaseAddress)
            };
        }

        public async Task<List<LogResponseDTO>> Get(LogSearchRequestDTO request)
        {
            var query = QueryStringHelper.ToQueryString(request);
            var response = await _httpClient.GetAsync($"{_requestUri}{query}");
            if (!response.IsSuccessStatusCode)
            {
                return [];
            }
            var result = await response.Content.ReadFromJsonAsync<List<LogResponseDTO>>();
            return result ?? [];
        }
    }
}
