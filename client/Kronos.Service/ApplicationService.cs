using Kronos.Domain.Configuration;
using Kronos.Domain.Dto.Application;
using Kronos.Service.Interface;
using System.Net.Http.Json;

namespace Kronos.Service
{
    public class ApplicationService : IApplicationService
    {
        private readonly HttpClient _httpClient;
        private readonly string _requestUri = "api/v1/Application";

        public ApplicationService()
        {
            _httpClient = new HttpClient
            {
                BaseAddress = new Uri(KronosConfigurationAPI.BaseAddress)
            };
        }

        public async Task<ApplicationResponseDTO?> Create(ApplicationCreateRequestDTO request)
        {
            var response = await _httpClient.PostAsJsonAsync(_requestUri, request);
            if (!response.IsSuccessStatusCode)
            {
                return null;
            }
            return await response.Content.ReadFromJsonAsync<ApplicationResponseDTO?>();
        }

        public async Task<bool> Delete(Guid applicationId)
        {
            var response = await _httpClient.DeleteAsync($"{_requestUri}/{applicationId}");
            return response.IsSuccessStatusCode;
        }

        public async Task<List<ApplicationResponseDTO>> Get()
        {
            var response = await _httpClient.GetAsync(_requestUri);
            if (!response.IsSuccessStatusCode)
            {
                return [];
            }
            var result = await response.Content.ReadFromJsonAsync<List<ApplicationResponseDTO>>();
            return result ?? [];
        }

        public async Task<ApplicationResponseDTO?> Update(ApplicationUpdateRequestDTO request)
        {
            var response = await _httpClient.PatchAsJsonAsync(_requestUri, request);
            if (!response.IsSuccessStatusCode)
            {
                return null;
            }
            return await response.Content.ReadFromJsonAsync<ApplicationResponseDTO?>();
        }
    }
}
