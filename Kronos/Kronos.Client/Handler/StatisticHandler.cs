using System.Net;
using Kronos.Domain.Configuration;
using Kronos.Domain.Dto.LogContent;
using Kronos.Domain.Helper;
using System.Net.Http.Json;
using Kronos.Domain.Dto.Statistic;

namespace Kronos.Client.Handler
{
    public class StatisticHandler
    {
        private readonly HttpClient _httpClient;
        private readonly string _requestUri = "api/v1/Statistic";

        public StatisticHandler()
        {
            _httpClient = new HttpClient
            {
                BaseAddress = new Uri(KronosConfigurationAPI.BaseAddress)
            };
        }

        public async Task<StatisticResponseDto?> Get(StatisticRequestDto request)
        {
            var query = QueryStringHelper.ToQueryString(request);
            var response = await _httpClient.GetAsync($"{_requestUri}{query}");
            if (!response.IsSuccessStatusCode || response.StatusCode == HttpStatusCode.NoContent)
            {
                return null;
            }
            var result = await response.Content.ReadFromJsonAsync<StatisticResponseDto>();
            return result;
        }
    }
}
