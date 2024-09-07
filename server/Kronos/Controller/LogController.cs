using Kronos.Domain.Dto.LogContent;
using Kronos.Domain.Interfaces.Service;
using Kronos.Extension;
using Microsoft.AspNetCore.Mvc;

namespace Kronos.Controller
{
    public class LogController(ILogService logService) : ControllerBaseExtension
    {
        private readonly ILogService _logService = logService;

        [HttpPost]
        public async Task<ActionResult<LogResponseDTO>> Create([FromBody] LogCreateRequestDTO request)
        {
            var response = await _logService.Create(request);
            if (response == null)
            {
                return BadRequest("Application not found");
            }
            return Ok(response);
        }

        [HttpGet]
        public async Task<ActionResult<List<LogResponseDTO>>> Get([FromQuery] LogSearchRequestDTO request)
        {
            var response = await _logService.Get(request);
            return Ok(response);
        }
    }
}
