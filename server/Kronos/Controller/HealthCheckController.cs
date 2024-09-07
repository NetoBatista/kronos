using Kronos.Domain.Dto.HealthCheck;
using Kronos.Domain.Interfaces.Service;
using Kronos.Extension;
using Microsoft.AspNetCore.Mvc;

namespace Kronos.Controller
{
    public class HealthCheckController(IHealthCheckService healthCheckService) : ControllerBaseExtension
    {
        private readonly IHealthCheckService _healthCheckService = healthCheckService;

        [HttpPost]
        public async Task<ActionResult<HealthCheckResponseDTO>> Create([FromBody] HealthCheckCreateRequestDTO request)
        {
            var response = await _healthCheckService.Create(request);
            return Ok(response);
        }

        [HttpGet]
        public async Task<ActionResult<List<HealthCheckResponseDTO>>> Get()
        {
            var response = await _healthCheckService.Get();
            return Ok(response);
        }

        [HttpPost("Applications")]
        public async Task<ActionResult> Applications()
        {
            await _healthCheckService.CheckAllApplications();
            return Ok();
        }
    }
}
